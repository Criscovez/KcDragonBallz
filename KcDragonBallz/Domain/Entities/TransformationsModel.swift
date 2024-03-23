//
//  TransformationsModel.swift
//  KcDragonBallz
//
//  Created by Cristian Contreras Velásquez on 19-03-24.
//

import Foundation

struct TransformationsModel: Codable {
    let id: UUID
    let name: String
    let photo: String
    let description: String
}

struct TransformationsModelRequest: Codable {
    let id: UUID
}
