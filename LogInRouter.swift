//
//  LogInRouter.swift
//  MyNote
//
//  Created by Yashom on 01/10/24.
//

import Foundation
import UIKit

protocol LogInRouterProtocol{
    var entry:LogInView?{get set}
    
    static func routing() -> LogInRouterProtocol
    func loggedIn()
    func signUp()
    
}

class LogInRouter:LogInRouterProtocol{
    var entry: LogInView?
    
    static func routing() -> LogInRouterProtocol {
        let view = LogInView()
        let presenter = LogInPresenter()
        let interactor = LogInInteractor()
        let router = LogInRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        
        router.entry = view
        return router
    }
    
    func loggedIn() {
        let router = NotesRouter.startExecution()
        let entryViewController = router.entry // Replace with your actual entry view controller class
        let navigation = UINavigationController(rootViewController: entryViewController!)
           // Get the SceneDelegate
           if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
               // Access the window safely
               if let window = sceneDelegate.window {
                   // Set the root view controller
                   window.rootViewController = navigation
                   
                   // Optionally add a transition animation
                   UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromRight, animations: {
                       window.rootViewController = navigation
                   }, completion: nil)
                   
                   window.makeKeyAndVisible()
               }
           }
        print("router")
    }
    
    func signUp() {
        let router = SignUp()
        
        let viewController = self.entry
        viewController?.navigationController?.pushViewController(router, animated: true)
    }
    
    
}
