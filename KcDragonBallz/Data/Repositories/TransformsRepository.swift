//
//  TransformsRepository.swift
//  KcDragonBallz
//
//  Created by Cristian Contreras Velásquez on 19-03-24.
//

import Foundation

//Real
final class TransformationsRepository: TransformationsRepositoryProtocol  {

    private var Network: NetworkTransformationsProtocol
    
    init(network: NetworkTransformationsProtocol = NetworkTransformations()){
        Network = network
    }
    
    func getTransformations(filter: UUID) async -> [TransformationsModel] {
        return await Network.getTransformations(filter: filter)
    }
}

//Fake
final class TransformationsRepositoryFake: TransformationsRepositoryProtocol {
    
    private var Network: NetworkTransformationsProtocol
    
    init(network: NetworkTransformationsProtocol = NetworkTransformationsFake()){
        Network = network
    }
    
    
    func getTransformations(filter: UUID) async -> [TransformationsModel] {
        return await Network.getTransformations(filter: filter)
    }
}
