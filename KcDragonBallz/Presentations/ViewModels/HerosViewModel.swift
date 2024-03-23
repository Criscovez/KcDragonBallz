//
//  HerosViewModel.swift
//  KcDragonBallz
//
//  Created by Cristian Contreras Velásquez on 18-03-24.
//

import Foundation
import Combine
final class HerosViewModel: ObservableObject {
    @Published var herosData = [HerosModel]()
    var heroId = UUID()
    
    private var userCaseHeros: herosUseCaseProtocol
    
    init(userCaseHeros: herosUseCaseProtocol = HeroUseCase()) {
        self.userCaseHeros = userCaseHeros
        
        Task(priority: .high) {
            await getHeros()
        }
        
    }
    
    //carga de los heroes
    func getHeros() async {
        let data = await userCaseHeros.getHeros(filter: "") //ahora no aplicamos el filtro
        
        //asigno en el hilo principal para la act. de la UI
        DispatchQueue.main.async {
            self.herosData = data
        }

    }
}
