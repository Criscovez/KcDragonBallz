//
//  TransformationsViewModel.swift
//  KcDragonBallz
//
//  Created by Cristian Contreras Velásquez on 19-03-24.
//

import Foundation
import Combine
final class TransformationsViewModel: ObservableObject {
    @Published var transformationsData = [TransformationsModel]()
    private var heroId : UUID
    
    private var userCaseTransformations: transformationsUseCaseProtocol
    
    init(userCaseTransformations: transformationsUseCaseProtocol = TransformationsUseCase(), heroId: UUID  ) {
        self.userCaseTransformations = userCaseTransformations
        self.heroId = heroId
        
        Task(priority: .high) {
            await getTransformations()
        }
        
    }
    
    //carga de los heroes
    func getTransformations() async {
        let data = await userCaseTransformations.getTransformations(filter: heroId) //ahora no aplicamos el filtro
        
        //asigno en el hilo principal para la act. de la UI
        DispatchQueue.main.async {
            self.transformationsData = data
        }

    }
}
