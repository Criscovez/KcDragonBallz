//
//  TransformationsUseCase.swift
//  KcDragonBallz
//
//  Created by Cristian Contreras Velásquez on 19-03-24.
//

import Foundation

protocol transformationsUseCaseProtocol {
    var repo: TransformationsRepositoryProtocol {get set}
    func getTransformations(filter: UUID) async -> [TransformationsModel]
}

//real

final class TransformationsUseCase: transformationsUseCaseProtocol {
    var repo: any TransformationsRepositoryProtocol
    
    init(repo: TransformationsRepositoryProtocol = TransformationsRepository(network: NetworkTransformations())) {
        self.repo = repo
    }
    
    func getTransformations(filter: UUID) async -> [TransformationsModel] {
        await repo.getTransformations(filter: filter)
    }
  
}

//Fake

final class TransformationsUseCaseFake: transformationsUseCaseProtocol {
    var repo: any TransformationsRepositoryProtocol
    
    init(repo: TransformationsRepositoryProtocol = TransformationsRepository(network: NetworkTransformationsFake())) {
        self.repo = repo
    }
    
    func getTransformations(filter: UUID) async -> [TransformationsModel] {
        await repo.getTransformations(filter: filter)
    }
  
}
