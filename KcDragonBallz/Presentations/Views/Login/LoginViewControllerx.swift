//
//  LoginViewControllerx.swift
//  KcDragonBallz
//
//  Created by Cristian Contreras Velásquez on 20-03-24.
//

import UIKit
import Combine

class LoginViewControllerx: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var buttonLogin: UIButton!
    
    private var suscriptors = Set<AnyCancellable>()
    private var appState: AppState?
    
    //usuario y clave
    private var user: String = ""
    private var pass: String = ""
    
    init(appState: AppState){
        self.appState = appState
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let emailTextfield = self.emailTextField{
            emailTextfield.textPublisher
                .receive(on: DispatchQueue.main)
                .sink { [weak self] data in
                    if let usr = data {
                        //print(usr)
                        self?.user = usr
                    }
                }
                .store(in: &suscriptors)
        }
        
        //password
        if let passwordTextfield = self.passwordTextField {
            passwordTextfield.textPublisher
                .receive(on: DispatchQueue.main)
                .sink { [weak self] data in
                    if let password = data {
                        //print(password)
                        self?.pass = password
                    }
                }
                .store(in: &suscriptors)
        }
        
        // suscriptor del boton
        self.buttonLogin.tapPublisher
            .sink {[weak self] _ in
                self?.appState?.statusLogin = .none
                //llamamos al login
                if let user = self?.user,
                   let pass = self?.pass {
                    self?.appState?.loginApp(user: user, pass: pass)
                }
           }
            .store(in: &suscriptors)

        setUpView()
        }
    
    func setUpView() {
        //imgen de fondo
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "fondo3")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        //boton login
        buttonLogin.setTitle(NSLocalizedString("Login", comment: "The Text passowrd"), for: .normal)
        buttonLogin.layer.cornerRadius = 20
        buttonLogin.layer.masksToBounds = true
        buttonLogin.layer.borderWidth = 2
        buttonLogin.layer.borderColor = UIColor.black.cgColor
        // text field password
        passwordTextField.placeholder = NSLocalizedString("Password", comment: "The Text passowrd")
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.layer.masksToBounds = true //sin esto no se ve el corner radius
        passwordTextField.layer.borderWidth = 2
        passwordTextField.layer.borderColor = UIColor.black.cgColor
        // text field e mail
        emailTextField.placeholder = NSLocalizedString("Email", comment: "Es el email")
        emailTextField.layer.cornerRadius = 10
        emailTextField.layer.masksToBounds = true //sin esto no se ve el corner radius
        emailTextField.layer.borderWidth = 2
        emailTextField.layer.borderColor = UIColor.black.cgColor
        
    }
    }
