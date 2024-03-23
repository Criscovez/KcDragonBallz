//
//  TransformationsTableViewController.swift
//  KcDragonBallz
//
//  Created by Cristian Contreras Velásquez on 18-03-24.
//

import UIKit
import Combine

class TransformationsTableViewController: UITableViewController {

    private var appState: AppState//?
    private var viewModel: TransformationsViewModel
   
    
    //combine
    private var suscriptors = Set<AnyCancellable>()
    
    init(appState: AppState, viewModel: TransformationsViewModel ) {
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
        tableView.register(UINib(nibName: "TransformationsTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell2")
        
        //titulo en el navigation controller
        self.title = "Lista de Transformaciones"
        
//        //añadir un boton para cerrar sesion
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeSession))
        
        //binding the view whith teh view model
        binding()
    }
    
//    @objc  func closeSession(){
//        appState.closeSessionUser()
//      }
      
      func binding() {
          self.viewModel.$transformationsData
              .receive(on: DispatchQueue.main)
              .sink(receiveValue: { _ in
                  //recargamos la tabla
                  self.tableView.reloadData()
              })
              .store(in: &suscriptors)
      }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.viewModel.transformationsData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath) as! TransformationsTableViewCell

        //el modelo
        let trasformation = viewModel.transformationsData[indexPath.row]
        
        //compongo la celda
        cell.transfDescription.text = trasformation.description
        cell.title.text = trasformation.name
        cell.photo.loadImageRemote(url: URL(string: trasformation.photo)!)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }



}
