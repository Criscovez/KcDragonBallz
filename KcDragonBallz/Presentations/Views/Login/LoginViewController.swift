//
//  LoginViewController.swift
//  KcDragonBallz
//
//  Created by Cristian Contreras Velásquez on 12-03-24.
//

import UIKit
import Combine
import CombineCocoa

class LoginViewController: UIViewController {
    
    
    //objetos que quiero crear en la UI
    var logo: UIImageView?
    var loginButton: UIButton?
    var emailTextfield: UITextField?
    var passwordTextfield: UITextField?
    
    //usuario y clave
    private var user: String = ""
    private var pass: String = ""
    
    //Combine
    private var suscriptor = Set<AnyCancellable>()
    
    
    private var appState: AppState?
    
    init(appState: AppState){
        self.appState = appState
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindingUI()
    }
    
    //suscriptores
    public func bindingUI() {
        //usuario (email)
        
        if let emailTextfield = self.emailTextfield {
            emailTextfield.textPublisher
                .receive(on: DispatchQueue.main)
                .sink { [weak self] data in
                    if let usr = data {
                        print(usr)
                        
                        self?.user = usr
                        
                        
                    }
                    
                }
                .store(in: &suscriptor)
        }
        
        //password
        if let passwordTextfield = self.passwordTextfield {
            passwordTextfield.textPublisher
                .receive(on: DispatchQueue.main)
                .sink { [weak self] data in
                    if let password = data {
                        print(password)
                        
                        self?.pass = password
                        
                        
                    }
                    
                }
                .store(in: &suscriptor)
        }
        
        //boton de login
        if let loginButton = self.loginButton {
            loginButton.tapPublisher
                .receive(on: DispatchQueue.main)
                .sink { [weak self] _ in
                    
                    //llamamos al login
                    if let user = self?.user,
                       let pass = self?.pass {
                        self?.appState?.loginApp(user: user, pass: pass)

                    }
                }
                .store(in: &suscriptor)
        }
    }
    
    // -- Creacion de la view
    

    
    //Creamos aqui la vista
    override func loadView() {
        let loginView = LoginView()
        
        //tenemos los objetos de la UI
        logo = loginView.getLogoImageView()
        loginButton = loginView.getButtonLoginView()
        emailTextfield = loginView.getEmailView()
        passwordTextfield = loginView.getPasswordView()
        
        //asigno la vista
        
        view = loginView
    }

    

}

//#Preview {
//    LoginViewController()
//}
