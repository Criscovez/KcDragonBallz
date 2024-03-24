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
    
    //carga de las transformaciones
    func getTransformations() async {
        let data = await userCaseTransformations.getTransformations(filter: heroId)
        

        DispatchQueue.main.async {
            self.transformationsData = data
        }

    }
}
