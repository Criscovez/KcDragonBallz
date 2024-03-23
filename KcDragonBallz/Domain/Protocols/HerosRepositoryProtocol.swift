//
//  HerosRepositoryProtocol.swift
//  KcDragonBallz
//
//  Created by Cristian Contreras Velásquez on 17-03-24.
//

import Foundation

protocol HerosRepositoryProtocol {
    func getHeros(filter: String) async -> [HerosModel]
}
