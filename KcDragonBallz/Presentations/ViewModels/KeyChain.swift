//
//  KeyChain.swift
//  KcDragonBallz
//
//  Created by Cristian Contreras Velásquez on 23-03-24.
//

import Foundation
import KeychainSwift

//funcion guardar
@discardableResult
func saveKC(key: String, value: String) -> Bool {
    if let data = value.data(using: .utf8) {
        let keyChain = KeychainSwift()
        return keyChain.set(data, forKey: key)
        
    } else {
        return false
    }
}

//funcion de recuperar

func loadKC(key: String) -> String? {
    if let data = KeychainSwift().get(key) {
        return data
    } else {
        return ""
    }
}


// funcion de eliminar
@discardableResult
func deleteKC(key: String) -> Bool{
    KeychainSwift().delete(key)
}
