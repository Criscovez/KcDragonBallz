//
//  KcDragonBallzTests.swift
//  KcDragonBallzTests
//
//  Created by Cristian Contreras Velásquez on 12-03-24.
//

import XCTest
@testable import KcDragonBallz
import Combine
import CombineCocoa
import UIKit
import KcLibraryswift

final class KcDragonBallzTests: XCTestCase {
    func testKeyChainLibrary() throws {
        let kc = KeyChainKC()
        XCTAssertNotNil(kc)
        
        let save = kc.saveKC(key: "Test", value: "123")
        XCTAssertEqual(save, true)
        
        let value = kc.loadKC(key: "Test")
        if let valor = value {
            XCTAssertEqual(valor, "123")
        }
        
        XCTAssertNoThrow(kc.deleteKC(key: "Test"))
    }
    
    func testNetworkLogin() async throws {
        let obj1 = NetworkLogin()
        XCTAssertNotNil(obj1)
        let obj2 = NetworkLoginFake()
        XCTAssertNotNil(obj2)
        
        let tokenFake = await obj2.loginApp(user: "", password: "")
        XCTAssertNotEqual(tokenFake, "")
        
        let token = await obj1.loginApp(user: "lala", password: "papa")
        XCTAssertEqual(token, "")
    }

    func testLoginFake() async throws {
        let KC = KeyChainKC()
        XCTAssertNotNil(KC)
        
        let obj = LoginUseCaseFake()
        XCTAssertNotNil(obj)
        
        //validar el token
        let resp = await obj.validateToken()
        XCTAssertEqual(resp, true)
        
        //login
        let loginDo = await obj.loginApp(user: "", password: "")
        XCTAssertEqual(loginDo, true)
        
        var jwt = KC.loadKC(key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN)
        XCTAssertNotEqual(jwt, "")
        
        //close session
        await obj.logout()
        jwt = KC.loadKC(key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN)
        XCTAssertEqual(jwt, "")
    }
        func testLoginReal() async throws {
            let KC = KeyChainKC()
            XCTAssertNotNil(KC)
            
            KC.saveKC(key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN, value: "")
            
            //Caso de uso repo Fake
            let useCase = LoginUseCase(repo: DefaultLoginRepositoryFake())
            XCTAssertNotNil(useCase)
            
            //validar
            
            let resp = await useCase.validateToken()
            XCTAssertEqual(resp, false)
            
            //login
            let loginDo = await useCase.loginApp(user: "", password: "")
            XCTAssertEqual(loginDo, true)
            
            var jwt = KC.loadKC(key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN)
            XCTAssertNotEqual(jwt, "")
            
            //close session
            await useCase.logout()
            jwt = KC.loadKC(key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN)
            XCTAssertEqual(jwt, "")
            
            
        }
    
    func testUIErrorView() async throws {
        let appStateVM = AppState(loginUseCase: LoginUseCaseFake())
        
        appStateVM.statusLogin = .error
        
        let vc = await ErrorViewController(appState: appStateVM, error: "Error")
        XCTAssertNotNil(vc)
        
        
    }
    
    func testUILoginView() throws {
        
        XCTAssertNoThrow(LoginView())
        
        let view = LoginView()
        XCTAssertNotNil(view)
        
        let logo = view.getLogoImageView()
        XCTAssertNotNil(logo)
        
        let txtUser = view.getEmailView()
        XCTAssertNotNil(txtUser)
        
        XCTAssertEqual(txtUser.placeholder, "correo electronico")
        
        let view2 = LoginViewController(appState: AppState(loginUseCase: LoginUseCaseFake()))
        
        
        
        //El binding
        XCTAssertNoThrow(view2.bindingUI())
        
        
        
    }
    
    // inicio de testing de heros
    
    func testHeroViewModel()  async throws {
        let vm = HerosViewModel(userCaseHeros: HeroUseCaseFake())
        
        XCTAssertNotNil(vm)
        
        XCTAssertEqual(vm.herosData.count, 0) //2
        
    }
    
    func testHerosUseCase() async throws {
        let usecase = HeroUseCase(repo: HerosRepositoryFake())
        XCTAssertNotNil(usecase)
        
        let data = await usecase.getHeros(filter: "")
        XCTAssertNotNil(data)
        XCTAssertEqual(data.count,2)
    }
    
    func testHerosCombine() async throws {
        var suscriptor = Set<AnyCancellable>()
        
        let exp = self.expectation(description: "Heros get")
        
        let vm = HerosViewModel(userCaseHeros: HeroUseCaseFake())
        XCTAssertNotNil(vm)
        
        //aqui la llamada a getHeros...
        
        vm.$herosData
            .sink { completion in
                switch completion {
                    
                case .finished:
                    print("finalizado")
                }
            } receiveValue: { data in
                if data.count == 2 {
                    exp.fulfill() //ha terminado la espera
                }
            }
            .store(in: &suscriptor)
        
        await self.waitForExpectations(timeout: 10)
        
    }
    
    func testHeros_Data() async throws {
        let network = NetworkHerosFake()
        XCTAssertNotNil(network)
        
        let repo = HerosRepository(network: network)
        XCTAssertNotNil(repo)
        
        let repo2 = HerosRepositoryFake()
        XCTAssertNotNil(repo2)
        
        let data = await repo.getHeros(filter: "")
        XCTAssertNotNil(data)
        XCTAssertEqual(data.count, 2)
        
        let data2 = await repo2.getHeros(filter: "")
        XCTAssertNotNil(data2)
        XCTAssertEqual(data2.count, 2)
    }
    
    func testHeros_Domain() async throws {
        let model = HerosModel(id: UUID(), favorite: true, description: "", photo: "", name: "goku")
        XCTAssertNotNil(model)
        
        XCTAssertEqual(model.name, "goku")
        XCTAssertEqual(model.favorite, true)
        
        
    }
    
    func testHeros_Presintation() async throws{
        let viewModel = HerosViewModel(userCaseHeros: HeroUseCaseFake())
        XCTAssertNotNil(viewModel)
        
        let view = await HerosTableViewController(appState: AppState(loginUseCase: LoginUseCaseFake() ), viewModel: viewModel)
        
        XCTAssertNotNil(view)
    }
        
        
    

}
