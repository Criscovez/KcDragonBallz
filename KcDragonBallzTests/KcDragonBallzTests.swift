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


final class KcDragonBallzTests: XCTestCase {
    func testKeyChainLibrary() throws {

        
        let save = saveKC(key: "Test", value: "123")
        XCTAssertEqual(save, true)
        
        let value = loadKC(key: "Test")
        if let valor = value {
            XCTAssertEqual(valor, "123")
        }
        
        XCTAssertNoThrow(deleteKC(key: "Test"))
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
    
    func testNetworkHeros() async throws {
        let obj1 = NetworkHeros()
        XCTAssertNotNil(obj1)
        let obj2 = NetworkHerosFake()
        XCTAssertNotNil(obj2)
        
        let heroFake = await obj2.getHeros(filter: "goku")
        XCTAssertNotEqual(heroFake.count, 0)
        
        let hero = await obj1.getHeros(filter: "goku")
        XCTAssertEqual(heroFake.count, 2)
    }
    
    func testNetworkTransformations() async throws {
        let obj1 = NetworkTransformations()
        XCTAssertNotNil(obj1)
        let obj2 = NetworkTransformationsFake()
        XCTAssertNotNil(obj2)
        
        let trasformationFake = await obj2.getTransformations(filter: UUID())
        XCTAssertNotEqual(trasformationFake.count, 0)
        
        let trasformation = await obj1.getTransformations(filter: UUID())
        XCTAssertEqual(trasformationFake.count, 3)
    }

    func testLoginFake() async throws {

        
        let obj = LoginUseCaseFake()
        XCTAssertNotNil(obj)
        
        //validar el token
        let resp = await obj.validateToken()
        XCTAssertEqual(resp, true)
        
        //login
        let loginDo = await obj.loginApp(user: "", password: "")
        XCTAssertEqual(loginDo, true)
        
        var jwt = loadKC(key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN)
        XCTAssertNotEqual(jwt, "")
        
        //close session
        await obj.logout()
        jwt = loadKC(key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN)
        XCTAssertEqual(jwt, "")
    }
    
    func testHeroFake() async throws {

        
        let obj = HeroUseCaseFake()
        XCTAssertNotNil(obj)
        
        //validar el token
        let resp = await obj.getHeros(filter: "goku")
        XCTAssertEqual(resp.first?.name, "Goku")

    }
        func testLoginReal() async throws {

            
            saveKC(key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN, value: "")
            
            //Caso de uso repo Fake
            let useCase = LoginUseCase(repo: DefaultLoginRepositoryFake())
            XCTAssertNotNil(useCase)
            
            //validar
            
            let resp = await useCase.validateToken()
            XCTAssertEqual(resp, false)
            
            //login
            let loginDo = await useCase.loginApp(user: "", password: "")
            XCTAssertEqual(loginDo, true)
            
            var jwt = loadKC(key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN)
            XCTAssertNotEqual(jwt, "")
            
            //close session
            await useCase.logout()
            jwt = loadKC(key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN)
            XCTAssertEqual(jwt, "")
            
            
        }
    

    
    func testUIErrorView() async throws {
        let appStateVM = AppState(loginUseCase: LoginUseCaseFake())
        
        appStateVM.statusLogin = .error
        
        let vc = await ErrorViewController(appState: appStateVM, error: "Error")
        XCTAssertNotNil(vc)
        
        
    }
    
//    func testUILoginView() throws {
//        
//        XCTAssertNoThrow(LoginView())
//        
//        let view = LoginView()
//        XCTAssertNotNil(view)
//        
//        let logo = view.getLogoImageView()
//        XCTAssertNotNil(logo)
//        
//        let txtUser = view.getEmailView()
//        XCTAssertNotNil(txtUser)
//        
//        XCTAssertEqual(txtUser.placeholder, "correo electronico")
//        
//        let view2 = LoginViewController(appState: AppState(loginUseCase: LoginUseCaseFake()))
//        
//        
//        
//        //El binding
//        XCTAssertNoThrow(view2.bindingUI())
//        
//        
//        
//    }
    
    // inicio de testing de heros
    
    func testHeroViewModel()  async throws {
        let vm = HerosViewModel(userCaseHeros: HeroUseCaseFake())
        
        XCTAssertNotNil(vm)
        
        XCTAssertEqual(vm.herosData.count, 0) //2
        
    }
    
    func testTransformationsViewModel()  async throws {
        let vm = TransformationsViewModel(userCaseTransformations: TransformationsUseCaseFake(), heroId: UUID())
        
        XCTAssertNotNil(vm)
        
        XCTAssertEqual(vm.transformationsData.count, 0) //2
        
    }
    
    func testHerosUseCase() async throws {
        let usecase = HeroUseCase(repo: HerosRepositoryFake())
        XCTAssertNotNil(usecase)
        
        let data = await usecase.getHeros(filter: "")
        XCTAssertNotNil(data)
        XCTAssertEqual(data.count,2)
    }
    
    func testTransformationsUseCase() async throws {
        let usecase = TransformationsUseCase(repo: TransformationsRepositoryFake())
        XCTAssertNotNil(usecase)
        
        let data = await usecase.getTransformations(filter: UUID())
        XCTAssertNotNil(data)
        XCTAssertEqual(data.count,3)
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
    
    func testTransformationsCombine() async throws {
        var suscriptor = Set<AnyCancellable>()
        
        let exp = self.expectation(description: "Transformations get")
        
        let vm = TransformationsViewModel(userCaseTransformations: TransformationsUseCaseFake(), heroId: UUID())
        XCTAssertNotNil(vm)
        
        //aqui la llamada a getHeros...
        
        vm.$transformationsData
            .sink { completion in
                switch completion {
                    
                case .finished:
                    print("finalizado")
                }
            } receiveValue: { data in
                if data.count == 3 {
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
    
    func testTransformations_Data() async throws {
        let network = NetworkTransformationsFake()
        XCTAssertNotNil(network)
        
        let repo = TransformationsRepository(network: network)
        XCTAssertNotNil(repo)
        
        let repo2 = TransformationsRepositoryFake()
        XCTAssertNotNil(repo2)
        
        let data = await repo.getTransformations(filter: UUID())
        XCTAssertNotNil(data)
        XCTAssertEqual(data.count, 3)
        
        let data2 = await repo2.getTransformations(filter: UUID())
        XCTAssertNotNil(data2)
        XCTAssertEqual(data2.count, 3)
    }
    
    func testHeros_Domain() async throws {
        let model = HerosModel(id: UUID(), favorite: true, description: "", photo: "", name: "goku")
        XCTAssertNotNil(model)
        
        XCTAssertEqual(model.name, "goku")
        XCTAssertEqual(model.favorite, true)
        
        
    }
    
    func testTransformations_Domain() async throws {
        let model = TransformationsModel(id: UUID(), name: "goku", photo: "photo", description: "goku")
        XCTAssertNotNil(model)
        
        XCTAssertEqual(model.name, "goku")
        XCTAssertEqual(model.photo, "photo")
        
        
    }
    
    func testHeros_Presentation() async throws{
        let viewModel = HerosViewModel(userCaseHeros: HeroUseCaseFake())
        XCTAssertNotNil(viewModel)
        
        let view = await HerosTableViewController(appState: AppState(loginUseCase: LoginUseCaseFake() ), viewModel: viewModel)
        
        XCTAssertNotNil(view)
    }
    
    func testTransformations_Presentation() async throws{
        let viewModel = TransformationsViewModel(userCaseTransformations: TransformationsUseCaseFake(), heroId: UUID())
        XCTAssertNotNil(viewModel)
        
        let view = await TransformationsTableViewController(appState: AppState(loginUseCase: LoginUseCaseFake() ), viewModel: viewModel)
        
        XCTAssertNotNil(view)
    }
        
        
    

}
