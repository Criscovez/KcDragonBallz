//
//  HeroUseCase.swift
//  KcDragonBallz
//
//  Created by Cristian Contreras Velásquez on 18-03-24.
//

import Foundation

protocol herosUseCaseProtocol {
    var repo: HerosRepositoryProtocol {get set}
    func getHeros(filter: String) async -> [HerosModel]
}

//real

final class HeroUseCase: herosUseCaseProtocol {
    var repo: HerosRepositoryProtocol
    
    init(repo: HerosRepositoryProtocol = HerosRepository(network: NetworkHeros())) {
        self.repo = repo
    }
    
    func getHeros(filter: String) async -> [HerosModel] {
        await repo.getHeros(filter: filter)
    }
}

//Fake

final class HeroUseCaseFake: herosUseCaseProtocol {
    var repo: HerosRepositoryProtocol
    
    init(repo: HerosRepositoryProtocol = HerosRepository(network: NetworkHerosFake())) {
        self.repo = repo
    }
    
    func getHeros(filter: String) async -> [HerosModel] {
        await repo.getHeros(filter: filter)
    }
}
