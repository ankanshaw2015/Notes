//
//  LogInPresenter.swift
//  MyNote
//
//  Created by Yashom on 01/10/24.
//

import Foundation

protocol LogInPresenterProtocol{
    var view: LogInViewProtocol?{get set}
    var interactor:LogInInteractorProtocol?{get set}
    var router:LogInRouterProtocol?{get set}
    
    func check(email:String,password:String)
    func validationSuccess(email:String)
    func validationFaild()
    func goToSignUp()
    func signUpData(email:String,password:String)
}

class LogInPresenter:LogInPresenterProtocol{
    var view: LogInViewProtocol?
    
    var interactor: LogInInteractorProtocol?
    
    var router: LogInRouterProtocol?
    
    func check(email: String, password: String) {
        interactor?.validateData(email: email, password: password)
        print(email,password)
    }
    
    func validationSuccess(email:String) {
        router?.loggedIn(email: email)
        print("present l")
    }
    
    func validationFaild() {
        view?.alert()
        print("faild")
    }
    func goToSignUp() {
        router?.signUp()
        print("login presenter SignUp")
    }
    
    func signUpData(email:String,password:String) {
        print("signIn presenter")
        interactor?.addData(email: email, password: password)
        print("signIn presenter")
    }
    
}
