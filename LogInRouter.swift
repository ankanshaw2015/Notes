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
   // var signUpView:SignUpView?{get set}
    static func routing() -> LogInRouterProtocol
    func loggedIn(email:String)
    func signUp()
    
}

class LogInRouter:LogInRouterProtocol{
  //  var signUpView: SignUpView?
    
    var entry: LogInView?
    
    static func routing() -> LogInRouterProtocol {
        let view = LogInView()
        let presenter = LogInPresenter()
        let interactor = LogInInteractor()
        let router = LogInRouter()
//        let signUpView = SignUpView()
//        signUpView.presenter = presenter
//        signUpView.a = "ankan"
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
    
        router.entry = view
        return router
    }
    
    func loggedIn(email:String) {
        let router = NotesRouter.startExecution(email: email)
        let entryViewController = router.entry
      
        
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
               print("email")
           }
        print("router")
    }
    
    func signUp() {
        let signUpView = SignUpView() // Create a new instance
        signUpView.presenter = entry?.presenter // Set the presenter if needed
            signUpView.a = "ankan" // Set any properties

            let viewController = self.entry // This should be LogInView

            // Ensure viewController is in a navigation controller before pushing
            if let navController = viewController?.navigationController {
                navController.pushViewController(signUpView, animated: true)
            } else {
                print("Navigation controller is nil.")
            }
            print("router sign up")
    }
    
    
}
