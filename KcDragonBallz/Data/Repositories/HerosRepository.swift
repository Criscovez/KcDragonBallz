//
//  HerosRepository.swift
//  KcDragonBallz
//
//  Created by Cristian Contreras Velásquez on 18-03-24.
//

import Foundation

//Real
final class HerosRepository: HerosRepositoryProtocol {
    
    private var Network: NetworkHerosProtocol
    
    init(network: NetworkHerosProtocol = NetworkHeros()){
        Network = network
    }
    
    func getHeros(filter: String) async -> [HerosModel] {

       return await Network.getHeros(filter: filter)
    }
}

//Fake
final class HerosRepositoryFake: HerosRepositoryProtocol {
    
    private var Network: NetworkHerosProtocol
    
    init(network: NetworkHerosProtocol = NetworkHerosFake()){
        Network = network
    }
    
    func getHeros(filter: String) async -> [HerosModel] {

       return await Network.getHeros(filter: filter)
    }
}
