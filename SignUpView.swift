//
//  SignUpView.swift
//  MyNote
//
//  Created by Yashom on 01/10/24.
//

import Foundation
import UIKit

class SignUp:UIViewController{
    var presenter: LogInPresenterProtocol?
    
//    private let lebal:UILabel = {
//        let lebal = UILabel()
//        lebal.textAlignment = .center
//        lebal.text = "not registered yet?"
//        lebal.font = .systemFont(ofSize: 10, weight: .semibold)
//        return lebal
//    }()
    
    private let email:UITextField = {
        let email = UITextField()
        email.backgroundColor = .yellow
        email.placeholder = "@gmail.com"
        email.layer.cornerRadius = 10
        email.borderStyle = .roundedRect
        return email
    }()
    
    private let password1:UITextField = {
        let pass = UITextField()
        pass.backgroundColor = .yellow
        pass.placeholder = "******"
        pass.layer.cornerRadius = 10
        pass.borderStyle = .roundedRect
        
        pass.isSecureTextEntry = true
        return pass
    }()
    
    private let password2:UITextField = {
        let pass = UITextField()
        pass.backgroundColor = .yellow
        pass.placeholder = "******"
        pass.layer.cornerRadius = 10
        pass.borderStyle = .roundedRect
        
        pass.isSecureTextEntry = true
        return pass
    }()
//
//    private let loginButton: UIButton = {
//         let button = UIButton(type: .system)
//         button.setTitle("Login", for: .normal)
//        button.backgroundColor = .yellow
//        button.layer.cornerRadius = 10
//        button.layer.shadowRadius = 2
//
//         return button
//     }()
    
    private let signUpButton: UIButton = {
         let button = UIButton(type: .system)
         button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = .yellow
        button.layer.cornerRadius = 10
         return button
     }()
    
    let logoImageView: UIImageView = {
          let imageView = UIImageView()
          imageView.image = UIImage(named: "list") // Replace with your image name
          imageView.contentMode = .scaleAspectFit
          imageView.translatesAutoresizingMaskIntoConstraints = false
          return imageView
      }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 255, green: 255, blue: 0, alpha: 0.3)
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
       // loginButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        align()
    }
    
    private func align(){
          
          // Create a stack view
          let stackView = UIStackView(arrangedSubviews: [email, password1,password2,signUpButton])
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
        
        view.addSubview(logoImageView)
        NSLayoutConstraint.activate([
               logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
               logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
               logoImageView.widthAnchor.constraint(equalToConstant: 100), // Adjust width as needed
               logoImageView.heightAnchor.constraint(equalToConstant: 100) // Adjust height as needed
           ])
        
    }
    
    @objc func signUpButtonTapped(){
        
    }
    
    
}
