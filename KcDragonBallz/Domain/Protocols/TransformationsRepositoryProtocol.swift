//
//  TransformsRepositoryProtocol.swift
//  KcDragonBallz
//
//  Created by Cristian Contreras Velásquez on 19-03-24.
//

import Foundation

protocol TransformationsRepositoryProtocol {
    func getTransformations(filter: UUID) async -> [TransformationsModel]
}
