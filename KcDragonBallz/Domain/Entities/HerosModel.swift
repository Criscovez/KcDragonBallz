//
//  HerosModel.swift
//  KcDragonBallz
//
//  Created by Cristian Contreras Velásquez on 17-03-24.
//

import Foundation

struct HerosModel: Codable {
    let id: UUID
    let favorite: Bool
    let description: String
    let photo: String
    let name: String
}

struct HerosModelRequest: Codable {
    let name: String
}
