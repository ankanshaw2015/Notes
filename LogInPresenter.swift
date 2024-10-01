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
    func validationSuccess()
    func validationFaild()
}

class LogInPresenter:LogInPresenterProtocol{
    var view: LogInViewProtocol?
    
    var interactor: LogInInteractorProtocol?
    
    var router: LogInRouterProtocol?
    
    func check(email: String, password: String) {
        interactor?.validateData(email: email, password: password)
    }
    
    func validationSuccess() {
        router?.loggedIn()
        print("present l")
    }
    
    func validationFaild() {
        view?.alert()
    }
    
    
}
