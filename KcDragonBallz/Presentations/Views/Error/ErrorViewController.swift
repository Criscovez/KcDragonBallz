//
//  ErrorViewController.swift
//  KcDragonBallz
//
//  Created by Cristian Contreras Velásquez on 14-03-24.
//

import UIKit
import Combine
import CombineCocoa

class ErrorViewController: UIViewController {
    
    @IBOutlet weak var viewLabel: UIView!
    @IBOutlet weak var lvlError: UILabel!
    @IBOutlet weak var buttonBack: UIButton!
    
    private var suscriptors = Set<AnyCancellable>()
    private var error: String?
    private var appState: AppState?
    
    init(appState: AppState? = nil, error: String? = nil) {
    
        self.error = error
        self.appState = appState
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {

        super.viewDidLoad()

        //muestro el error en la label
        self.lvlError.text = self.error
        
        // suscriptor del boton
        self.buttonBack.tapPublisher
            .sink {[weak self] _ in
                self?.appState?.statusLogin = .none
                
           }
            .store(in: &suscriptors)
        
        setUpView()
    }
    
    func setUpView() {
        //Boton
        buttonBack.setTitle(NSLocalizedString("Back", comment: "Back to login"), for: .normal)
        buttonBack.layer.cornerRadius = 20
        buttonBack.layer.masksToBounds = true
        buttonBack.layer.borderWidth = 2
        buttonBack.layer.borderColor = UIColor.black.cgColor
        //imagen de fondo
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "fondo3")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        //view con mensaje de error
        viewLabel.layer.cornerRadius = 20
        viewLabel.layer.masksToBounds = true
        viewLabel.layer.borderWidth = 2
        viewLabel.layer.borderColor = UIColor.black.cgColor
        
    }
}
