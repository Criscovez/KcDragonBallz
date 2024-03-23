//
//  HerosTableTableViewController.swift
//  KcDragonBallz
//
//  Created by Cristian Contreras Velásquez on 18-03-24.
//

import UIKit
import Combine

class HerosTableViewController: UITableViewController {

    
    //TODO: viewModel appState, heroes
    private var appState: AppState
    private var viewModel: HerosViewModel
    
    //combine
    private var suscriptors = Set<AnyCancellable>()
    
    init(appState: AppState, viewModel: HerosViewModel) {
        self.appState = appState
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        self.view.backgroundColor = .colorYellow
        

        //reguistro de celda personalizada
        tableView.register(UINib(nibName: "HeroTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        //titulo en el navigation controller
        self.title = "Lista de heroes"
        
        //añadir un boton para cerrar sesion
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeSession))
        
        //binding the view whith teh view model
        binding()

    }
    
    
    
    
  @objc  func closeSession(){
      appState.closeSessionUser()
    }
    
    func binding() {
        self.viewModel.$herosData
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { data in
                //recargamos la tabla
                print("data binding\(data)")
                self.tableView.reloadData()
            })
            .store(in: &suscriptors)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.viewModel.herosData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HeroTableViewCell

        //el modelo
        let hero = viewModel.herosData[indexPath.row]
        viewModel.heroId = hero.id
        
        //compongo la celda
        cell.heroDescription.text = hero.description
        cell.title.text = hero.name
        cell.photo.loadImageRemote(url: URL(string: hero.photo)!)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let heroId = self.viewModel.herosData[indexPath.row].id
        
        DispatchQueue.main.async {
            print("pal transformations\(heroId)")
            //let hero = self.heroes[indexPath.row]
            //let transformationsViewController = HeroDetailViewController(hero: heroId)
            let transformationsViewController = TransformationsTableViewController(appState: self.appState, viewModel: TransformationsViewModel(heroId: heroId))
            self.navigationController?.show(transformationsViewController, sender: nil)
            
        }
    }
}


    
    


//#Preview {
//    HerosTableViewController(appState: AppState(loginUseCase: LoginUseCaseFake()), viewModel: HerosViewModel(userCaseHeros: HeroUseCaseFake()))
//}
