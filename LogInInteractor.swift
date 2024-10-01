//
//  LogInInteractor.swift
//  MyNote
//
//  Created by Yashom on 01/10/24.
//

import Foundation

protocol LogInInteractorProtocol{
    
    var presenter:LogInPresenterProtocol?{get set}
    
    func validateData(email:String,password:String)
}

class LogInInteractor:LogInInteractorProtocol{
    var presenter: LogInPresenterProtocol?
    var userData = UserData().users
    func validateData(email: String, password: String) {
        
        for data in userData{
            if userData.count == 0{
                presenter?.validationFaild()
                return
            }
           else if data.email == email && data.Password == password{
                presenter?.validationSuccess()
                return
            }
        }
            presenter?.validationFaild()
    }
    
    
}
