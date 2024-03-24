//
//  NetworkTransformations.swift
//  KcDragonBallz
//
//  Created by Cristian Contreras Velásquez on 19-03-24.
//

import Foundation

protocol NetworkTransformationsProtocol {
    func getTransformations(filter: UUID) async -> [TransformationsModel]
}

final class NetworkTransformations: NetworkTransformationsProtocol {
    func getTransformations(filter: UUID) async -> [TransformationsModel] {
        var modelReturn = [TransformationsModel]()
        let urlCad = "\(ConstantsApp.CONST_API_URL)\(Endpoints.transformations.rawValue)"
        var request = URLRequest(url: URL(string: urlCad)!)
        request.httpMethod = HTTPMethods.post
        request.httpBody = try? JSONEncoder().encode(TransformationsModelRequest(id: filter))
        request.addValue(HTTPMethods.content, forHTTPHeaderField: "Content-type")
        
        //necesitamos el token JWT
        let tokenJWT = loadKC(key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN)
        
        if let token = tokenJWT {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        //Call to server side
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let resp = response as? HTTPURLResponse {
                if resp.statusCode == HTTPRresponseCodes.SUCESS {
                    modelReturn = try! JSONDecoder().decode([TransformationsModel].self, from: data)
                }
            }
        } catch {
            
        }
        
        return modelReturn
    }
}

final class NetworkTransformationsFake: NetworkTransformationsProtocol {
    func getTransformations(filter: UUID) async -> [TransformationsModel] {
        
        let model1 = TransformationsModel(id: UUID(), name: "Oozaru – Gran Mono", photo: "https://areajugones.sport.es/wp-content/uploads/2021/05/ozarru.jpg.webp", description: "Cómo todos los Saiyans con cola, Goku es capaz de convertirse en un mono gigante si mira fijamente a la luna llena. Así es como Goku cuando era un infante liberaba todo su potencial a cambio de perder todo el raciocinio y transformarse en una auténtica bestia. Es por ello que sus amigos optan por cortarle la cola para que no ocurran desgracias, ya que Goku mató a su propio abuelo adoptivo Son Gohan estando en este estado. Después de beber el Agua Ultra Divina, Goku liberó todo su potencial sin necesidad de volver a convertirse en Oozaru")
        
        let model2 = TransformationsModel(id: UUID(), name: "2. Kaio-Ken", photo: "https://areajugones.sport.es/wp-content/uploads/2017/05/Goku_Kaio-Ken_Coolers_Revenge.jpg", description: "La técnica de Kaio-sama permitía a Goku aumentar su poder de forma exponencial durante un breve periodo de tiempo para intentar realizar un ataque que acabe con el enemigo, ya que después de usar esta técnica a niveles altos el cuerpo de Kakarotto queda exhausto. Su máximo multiplicador de poder con esta técnica es de hasta x20, aunque en la película en la que se enfrenta contra Lord Slug es capaz de envolverse en éste aura roja a nivel x100")
        
        let model3 = TransformationsModel(id: UUID(), name: "3. Super Saiyan Falso", photo: "https://areajugones.sport.es/wp-content/uploads/2021/05/pseudo-super-saiyan.jpg.webp", description: "A este nivel de Super Saiyan se le conoce como False-Super Saiyan, Fake-Super Saiyan, Pseudo-Super Saiyan e incluso Saiyan 1.5. Dicha transformación nunca llega a ser canon puesto que sucedió en la batalla contra Lord Slug, en la cual Goku recurre a este nuevo nivel de poder en el que se embulle en un aura amarilla, su pelo se eriza y coge tintes rojizos, su musculatura aumenta y sus ojos se quedan totalmente en blanco como si hubiese perdido totalmente el juicio.")

       return [model1, model2, model3]
       
    }
}
