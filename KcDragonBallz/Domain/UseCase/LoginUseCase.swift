//
//  LoginUseCase.swift
//  KcDragonBallz
//
//  Created by Cristian Contreras Velásquez on 14-03-24.
//

import Foundation
import UIKit
import KcLibraryswift



protocol LoginUseCaseProtocol {
    var repo: LoginRepositoryProtocol {get set}
    func loginApp(user: String, password: String) async -> Bool
    func logout() async -> Void
    func validateToken() async -> Bool
}

//implemetamos el caso de uso
final class LoginUseCase: LoginUseCaseProtocol {
    var repo: LoginRepositoryProtocol
    
    init(repo: LoginRepositoryProtocol = DefaultLoginRepository(Network: NetworkLogin())) {
        self.repo = repo
    }
    
    func loginApp(user: String, password: String) async -> Bool {
        
        let token = await repo.loginApp(user: user, password: password)
        //guardar token en keychanin
        
        if token != "" {
            KeyChainKC().saveKC(key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN, value: token)
            return true
        } else {
            KeyChainKC().deleteKC(key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN)
            return false
            
        }
       
    }
    
    func logout() async {
        KeyChainKC().deleteKC(key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN)
        //logout
    }
    
    func validateToken() async -> Bool {
        if KeyChainKC().loadKC(key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN) != "" {
            return true
        } else {
            return false
        }
    }
    

}

final class LoginUseCaseFake: LoginUseCaseProtocol {
    var repo: LoginRepositoryProtocol
    
    init(repo: LoginRepositoryProtocol = DefaultLoginRepositoryFake()) {
        self.repo = repo
    }
    
    func loginApp(user: String, password: String) async -> Bool {
        
        let token = await repo.loginApp(user: user, password: password)
        //guardar token en keychanin
        
        if token != "" {
            KeyChainKC().saveKC(key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN, value: token)
            return true
        } else {
            KeyChainKC().deleteKC(key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN)
            return false
            
        }
       
    }
    
    func logout() async {
        KeyChainKC().deleteKC(key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN)
        //logout
    }
    
    func validateToken() async -> Bool {

            return true
  
    }
    

}
