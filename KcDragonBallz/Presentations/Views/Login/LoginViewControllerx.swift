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
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "fondo3")!)
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "fondo3")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        buttonLogin.setTitle(NSLocalizedString("Login", comment: "The Text passowrd"), for: .normal)
        
       
        

        
//        buttonLogin.backgroundColor = .blue.withAlphaComponent(0.9)
//        buttonLogin.setTitleColor(.white, for: .normal)
//        buttonLogin.setTitleColor(.gray,  for: .disabled)
        buttonLogin.layer.cornerRadius = 20
//        buttonLogin.translatesAutoresizingMaskIntoConstraints = false
        buttonLogin.layer.masksToBounds = true
        buttonLogin.layer.borderWidth = 2
        buttonLogin.layer.borderColor = UIColor.black.cgColor
        
//        passwordTextField.backgroundColor = .blue.withAlphaComponent(0.9)
//        passwordTextField.textColor = .white
//        passwordTextField.font = UIFont.systemFont(ofSize: 18)
//        passwordTextField.borderStyle = .roundedRect
//        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
//        passwordTextField.autocapitalizationType = .none
//        passwordTextField.autocorrectionType = .no
        passwordTextField.placeholder = NSLocalizedString("Password", comment: "The Text passowrd")
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.layer.masksToBounds = true //sin esto no se ve el corner radius
        passwordTextField.layer.borderWidth = 2
        passwordTextField.layer.borderColor = UIColor.black.cgColor
//        passwordTextField.isSecureTextEntry = true
        
        
//        emailTextField.backgroundColor = .blue.withAlphaComponent(0.9)
//        emailTextField.textColor = .white
//        emailTextField.font = UIFont.systemFont(ofSize: 18)
//        emailTextField.borderStyle = .roundedRect
//        emailTextField.translatesAutoresizingMaskIntoConstraints = false
//        emailTextField.autocapitalizationType = .none
//        emailTextField.autocorrectionType = .no
        emailTextField.placeholder = NSLocalizedString("Email", comment: "Es el email")
        emailTextField.layer.cornerRadius = 10
        emailTextField.layer.masksToBounds = true //sin esto no se ve el corner radius
        emailTextField.layer.borderWidth = 2
        emailTextField.layer.borderColor = UIColor.black.cgColor
        
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let emailTextfield = self.emailTextField{
            emailTextfield.textPublisher
                .receive(on: DispatchQueue.main)
                .sink { [weak self] data in
                    if let usr = data {
                        print(usr)
                        
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
                        print(password)
                        
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


    }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

//
//
//class ErrorViewController: UIViewController {
//    
//    @IBOutlet weak var lvlError: UILabel!
//    @IBOutlet weak var buttonBack: UIButton!
//    
//    private var suscriptors = Set<AnyCancellable>()
//    private var error: String?
//    private var appState: AppState?
//    
//    init(appState: AppState? = nil, error: String? = nil) {
//    
//        self.error = error
//        self.appState = appState
//        
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        //muestro el error en la label
//        self.lvlError.text = self.error
//        
//        // suscriptor del boton
//     
//        
//        self.buttonBack.tapPublisher
//            .sink {[weak self] _ in
//                self?.appState?.statusLogin = .none
//                
//           }
//            .store(in: &suscriptors)
//
//
//    }
//
//
//}
//
//class LoginViewController: UIViewController {
//    
//    
//    //objetos que quiero crear en la UI
//    var logo: UIImageView?
//    var loginButton: UIButton?
//    var emailTextfield: UITextField?
//    var passwordTextfield: UITextField?
//    
//    //usuario y clave
//    private var user: String = ""
//    private var pass: String = ""
//    
//    //Combine
//    private var suscriptor = Set<AnyCancellable>()
//    
//    
//    private var appState: AppState?
//    
//    init(appState: AppState){
//        self.appState = appState
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        bindingUI()
//    }
//    
//    //suscriptores
//    public func bindingUI() {
//        //usuario (email)
//        
//        if let emailTextfield = self.emailTextfield {
//            emailTextfield.textPublisher
//                .receive(on: DispatchQueue.main)
//                .sink { [weak self] data in
//                    if let usr = data {
//                        print(usr)
//                        
//                        self?.user = usr
//                        
//                        
//                    }
//                    
//                }
//                .store(in: &suscriptor)
//        }
//        
//        //password
//        if let passwordTextfield = self.passwordTextfield {
//            passwordTextfield.textPublisher
//                .receive(on: DispatchQueue.main)
//                .sink { [weak self] data in
//                    if let password = data {
//                        print(password)
//                        
//                        self?.pass = password
//                        
//                        
//                    }
//                    
//                }
//                .store(in: &suscriptor)
//        }
//        
//        //boton de login
//        if let loginButton = self.loginButton {
//            loginButton.tapPublisher
//                .receive(on: DispatchQueue.main)
//                .sink { [weak self] _ in
//                    
//                    //llamamos al login
//                    if let user = self?.user,
//                       let pass = self?.pass {
//                        self?.appState?.loginApp(user: user, pass: pass)
//
//                    }
//                }
//                .store(in: &suscriptor)
//        }
//    }
//    
//    // -- Creacion de la view
//    
//
//    
//    //Creamos aqui la vista
//    override func loadView() {
//        let loginView = LoginView()
//        
//        //tenemos los objetos de la UI
//        logo = loginView.getLogoImageView()
//        loginButton = loginView.getButtonLoginView()
//        emailTextfield = loginView.getEmailView()
//        passwordTextfield = loginView.getPasswordView()
//        
//        //asigno la vista
//        
//        view = loginView
//    }
//
//    
//
//}
