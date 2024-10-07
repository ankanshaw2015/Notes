//
//  LogInView.swift
//  MyNote
//
//  Created by Yashom on 01/10/24.
//

import Foundation
import UIKit
import Lottie

protocol LogInViewProtocol{
    
    var presenter : LogInPresenterProtocol?{get set}
    
    func alert()
}


class LogInView:UIViewController,LogInViewProtocol{
    var presenter: LogInPresenterProtocol?
    
    private let lebal:UILabel = {
        let lebal = UILabel()
        lebal.textAlignment = .center
        lebal.text = "not registered yet?"
        lebal.font = .systemFont(ofSize: 14, weight: .semibold)
        return lebal
    }()
    
    private let logInLabel:UILabel = {
        let lebal = UILabel()
        lebal.textAlignment = .center
        lebal.text = "Login to your account"
        lebal.font = .systemFont(ofSize: 24, weight: .semibold)
        return lebal
    }()
    
    private let email:UITextField = {
        let email = UITextField()
        email.layer.borderWidth = 2
        email.autocapitalizationType = .none
        email.backgroundColor = .yellow
        email.placeholder = "@gmail.com"
        email.layer.cornerRadius = 10
        email.borderStyle = .roundedRect
        return email
    }()
    
    private let password:UITextField = {
        let pass = UITextField()
        pass.backgroundColor = .yellow
        pass.placeholder = "******"
        pass.layer.cornerRadius = 10
        pass.borderStyle = .roundedRect
        pass.layer.borderWidth = 2
        pass.isSecureTextEntry = true
        pass.autocapitalizationType = .none
        return pass
    }()
    
    private let loginButton: UIButton = {
         let button = UIButton(type: .system)
         button.setTitle("Login", for: .normal)
        button.backgroundColor = .yellow
        button.layer.cornerRadius = 10
        button.layer.shadowRadius = 2
        button.layer.borderWidth = 2
        
         return button
     }()
    
    private let signUpButton: UIButton = {
         let button = UIButton(type: .system)
         button.setTitle("Sign Up Now", for: .normal)
        
         return button
     }()
    
    
    private var logoImageView: LottieAnimationView?
    
//    let logoImageView: UIImageView = {
//          let imageView = UIImageView()
//          imageView.image = UIImage(named: "list") // Replace with your image name
//          imageView.contentMode = .scaleAspectFit
//          imageView.translatesAutoresizingMaskIntoConstraints = false
//          return imageView
//      }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 1.0, green: 0.8, blue: 0.6, alpha: 1.0)
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        loadProfile()
        align()
   
    }
    
    func loadProfile(){
        logoImageView = .init(name: "logIn")
          
        logoImageView!.frame = CGRect(x: Int(view.frame.width/2 - 80), y: Int((view.frame.height/2) - 300), width: 150, height: 150)
          
          // 3. Set animation content mode
          
        logoImageView!.contentMode = .scaleAspectFit
          
          // 4. Set animation loop mode
          
        logoImageView!.loopMode = .loop
          
          // 5. Adjust animation speed
          
        logoImageView!.animationSpeed = 1
          
          view.addSubview(logoImageView!)
          
          // 6. Play animation
          
        logoImageView!.play()
        
    }

    
    private func align(){
          
          // Create a stack view
          let stackView = UIStackView(arrangedSubviews: [logInLabel,email, password,loginButton])
          stackView.axis = .vertical
          stackView.spacing = 16
          stackView.translatesAutoresizingMaskIntoConstraints = false
          
          // Add the stack view to the view
          view.addSubview(stackView)
          
          // Set constraints for the stack view
          NSLayoutConstraint.activate([
              stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
              stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
              stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
              stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
          ])
        
        let stackView1 = UIStackView(arrangedSubviews: [lebal,signUpButton])
        stackView1.axis = .horizontal
        stackView1.spacing = 8
        stackView1.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView1)
        
        NSLayoutConstraint.activate([
            stackView1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView1.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
           // stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
    //    view.addSubview(logoImageView!)
        NSLayoutConstraint.activate([
               logoImageView!.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
               logoImageView!.centerXAnchor.constraint(equalTo: view.centerXAnchor),
               logoImageView!.widthAnchor.constraint(equalToConstant: 150), // Adjust width as needed
               logoImageView!.heightAnchor.constraint(equalToConstant: 150) // Adjust height as needed
           ])
        
    }
    
    @objc func loginButtonTapped(){
       
        guard let email = email.text,let pass = password.text, !email.isEmpty,!pass.isEmpty else{
            return
        }
        presenter?.check(email:email, password: pass)
        print("log in tapped")
    }
    
    @objc func signUpButtonTapped(){
        presenter?.goToSignUp()
        
    }
    
    func alert() {
        let alert = UIAlertController(title: "You don't have a account", message: "Do You Like to Register?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "cancel", style: .cancel,handler: nil))
        alert.addAction(UIAlertAction(title: "Sign Up", style: .default,handler: { _ in
            self.presenter?.goToSignUp()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
}
