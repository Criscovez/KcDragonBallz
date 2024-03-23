//
//  LoginView.swift
//  KcDragonBallz
//
//  Created by Cristian Contreras Velásquez on 12-03-24.
//

import Foundation
import UIKit

//generamos la UI por codigo

class LoginView: UIView {
    //logo
    public let logoImage = {
        let image = UIImageView(image: UIImage(named: "title"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    //ususario
    public let emailTextField = {
        let textField = UITextField()
        textField.backgroundColor = .blue.withAlphaComponent(0.9)
        textField.textColor = .white
        textField.font = UIFont.systemFont(ofSize: 18)
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.placeholder = NSLocalizedString("Email", comment: "Es el email")
        textField.layer.cornerRadius = 10
        textField.layer.masksToBounds = true //sin esto no se ve el corner radius
        return textField
    }()
    //Clave
    public let passwordTextField = {
        let textField = UITextField()
        textField.backgroundColor = .blue.withAlphaComponent(0.9)
        textField.textColor = .white
        textField.font = UIFont.systemFont(ofSize: 18)
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.placeholder = NSLocalizedString("Password", comment: "The Text passowrd")
        textField.layer.cornerRadius = 10
        textField.layer.masksToBounds = true //sin esto no se ve el corner radius
        textField.isSecureTextEntry = true

        return textField
    }()
    
    
    //boton
    public let buttonLogin = {
        let button = UIButton(type: .system)
        button.setTitle(NSLocalizedString("Login", comment: "The Text passowrd"), for: .normal)
        
        button.backgroundColor = .blue.withAlphaComponent(0.9)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.gray,  for: .disabled)
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init coder no ha sido implementado")
    }
    
    func setupViews(){
        //añadimos los items de laUI a la view
        
        let backImage = UIImage(named: "fondo3")!
        backgroundColor = UIColor(patternImage: backImage)
        
        addSubview(logoImage)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(buttonLogin)
        
        //reglas de autoLayout
        
        NSLayoutConstraint.activate([
            //logo
            logoImage.topAnchor.constraint(equalTo: topAnchor, constant: 120),
            logoImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant:20),
            logoImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            logoImage.heightAnchor.constraint(equalToConstant: 70),
            
            //user
            emailTextField.topAnchor.constraint(equalTo: logoImage.bottomAnchor,constant:100),
            emailTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant:50),
            emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            
            //password
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor,constant:40),
            passwordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant:50),
            passwordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            //boton
            buttonLogin.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor,constant:75),
            buttonLogin.leadingAnchor.constraint(equalTo: leadingAnchor, constant:80),
            buttonLogin.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -80),
            buttonLogin.heightAnchor.constraint(equalToConstant: 50)
            
            
        ])
    }

    //funciones para devolver los objetos al ViewController
    
    func getEmailView() -> UITextField {
        emailTextField
    }
    
    func getPasswordView() -> UITextField {
        passwordTextField
    }
    
    func getLogoImageView() -> UIImageView {
        logoImage
    }
    func getButtonLoginView() -> UIButton {
        buttonLogin
    }
}

