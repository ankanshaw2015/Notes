//
//  SplaceScreen.swift
//  MyNote
//
//  Created by Yashom on 04/10/24.
//

import UIKit
import Lottie
class SplashViewController: UIViewController {

    private var animationView: LottieAnimationView?
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "rectangle.stack.badge.plus")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 1.0, green: 0.8, blue: 0.6, alpha: 1.0)
        
        animationView = .init(name: "note")
          
          animationView!.frame = view.bounds
          
          // 3. Set animation content mode
          
          animationView!.contentMode = .scaleAspectFit
          
          // 4. Set animation loop mode
          
          animationView!.loopMode = .loop
          
          // 5. Adjust animation speed
          
          animationView!.animationSpeed = 1
          
          view.addSubview(animationView!)
          
          // 6. Play animation
          
          animationView!.play()
          
        //setupLogo()
    }

    // Set up the logo image view constraints to center it
    private func setupLogo() {
        view.addSubview(logoImageView)
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),  // Adjust the size of the logo as needed
            logoImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }

    // Public function to transition to the main view controller after a delay
    func transitionToMainView(window: UIWindow?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {  // 2-second delay for splash screen
            guard let window = window else { return }
            
            // Creating the main view controller using the VIPER router
            let router = NotesRouter.startExecution(email: "user@gmail.com")
            //let router = LogInRouter.routing()
            let mainViewController = router.entry
            
            // Set the main view controller as the root of a navigation controller
            window.rootViewController = UINavigationController(rootViewController: mainViewController!)
            
            // Animate the transition
            UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil, completion: nil)
            
//            guard let windowScene = (scene as? UIWindowScene) else { return }
//            window = UIWindow(windowScene: windowScene)
//
//            let router = NotesRouter.startExecution(email: "user@gmail.com")
//            //let router = LogInRouter.routing()
//            let initialViewControler = router.entry!
//
//            let navigation = UINavigationController()
//            navigation.viewControllers = [initialViewControler]
//
//            window?.rootViewController = navigation
//            window?.makeKeyAndVisible()
//            window?.backgroundColor = .systemBackground
        }
    }
}
