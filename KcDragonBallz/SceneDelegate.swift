//
//  SceneDelegate.swift
//  KcDragonBallz
//
//  Created by Cristian Contreras Velásquez on 12-03-24.
//

import UIKit
import Combine

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appState: AppState = AppState(loginUseCase: LoginUseCase()) //Aqui el view model global
    var cancelable: AnyCancellable?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowsScene = (scene as? UIWindowScene) else { return }
        
        self.window = UIWindow(windowScene: windowsScene)
        
        //evaluar si se puede hacer auto-login
        appState.validateControlLogin()
        
        //creamos un navigator controller
        var  nav: UINavigationController?
        
        //la caja de estados o viewRouter
        self.cancelable = appState.$statusLogin
            .sink(receiveValue: { estado in
                switch estado {
                    
                case .notValidate, .none:
                    //ver el login
                    DispatchQueue.main.async {
                        print("login")
                        nav = UINavigationController(rootViewController: LoginViewControllerx(appState: self.appState))
                        
                        self.window!.rootViewController = nav
                        self.window!.makeKeyAndVisible()
                    }
                case .success:
                    //la home
                    
                    DispatchQueue.main.async {
                        print("heroes")
                        nav = UINavigationController(rootViewController: HerosTableViewController(appState: self.appState, viewModel: HerosViewModel()))
                        
                        self.window!.rootViewController = nav
                        self.window!.makeKeyAndVisible()
                    }
                case .error:
                    //error
                    DispatchQueue.main.async {
                        print("error")
                        nav = UINavigationController(rootViewController: ErrorViewController(appState: self.appState, error: "Error usuario / Clave"))
                        
                        self.window!.rootViewController = nav
                        self.window!.makeKeyAndVisible()
                    }

                }
            })
        
        

    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

