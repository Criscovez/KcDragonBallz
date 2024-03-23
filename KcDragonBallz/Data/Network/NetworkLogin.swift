//
//  NetworkLogin.swift
//  KcDragonBallz
//
//  Created by Cristian Contreras Velásquez on 14-03-24.
//

import Foundation

protocol NetworkLoginProtocol {
    func loginApp(user: String, password: String) async -> String
}

final class NetworkLogin : NetworkLoginProtocol {
    func loginApp(user: String, password: String) async -> String {
        var tokenJWT: String = ""
        let urlCad = "\(ConstantsApp.CONST_API_URL)\(Endpoints.login.rawValue)"
        let encodeCredentials = "\(user):\(password)".data(using: .utf8)?.base64EncodedString()
        
        var segCredential: String = ""
        if let credentials = encodeCredentials {
            segCredential = "Basic \(credentials)"
        }
        
        //creamos la request
        var request: URLRequest = URLRequest(url: URL(string: urlCad)!)
        request.httpMethod = HTTPMethods.post
        request.addValue(HTTPMethods.content, forHTTPHeaderField: "Content-type")
        request.addValue(segCredential, forHTTPHeaderField: "authorization")
        
        //LLamamos al server
        
        do{
            let (data, response) = try await URLSession.shared.data(for: request)
            if let resp = response as? HTTPURLResponse {
                if resp.statusCode == HTTPRresponseCodes.SUCESS {
                    tokenJWT = String(decoding: data, as: UTF8.self)
                }
            }
            
        } catch {
            tokenJWT = ""
        }
        return tokenJWT
    }
}

final class NetworkLoginFake: NetworkLoginProtocol {
    func loginApp(user: String, password: String) async -> String {
        UUID().uuidString
    }
    
    
}
