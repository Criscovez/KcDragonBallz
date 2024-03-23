//
//  LoginRepositoryProtocol.swift
//  KcDragonBallz
//
//  Created by Cristian Contreras Velásquez on 14-03-24.
//

import Foundation

protocol LoginRepositoryProtocol {
    func loginApp(user: String, password: String) async -> String //Devuelve el token JWT
}
