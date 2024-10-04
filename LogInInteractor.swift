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
    func addData(email:String,password:String)
}

class LogInInteractor:LogInInteractorProtocol{
    var presenter: LogInPresenterProtocol?
    let users = UserData()
    
    func validateData(email: String, password: String) {
        let userData = users.users
        if userData.count == 0{
            presenter?.validationFaild()
            return
        }
        for data in userData{
            if data.email == email && data.Password == password{
                print("success")
                presenter?.validationSuccess(email: email)
                return
            }
        }
            presenter?.validationFaild()
//        if email == password{
//            presenter?.validationSuccess(email: email)
//        }
//        else{
//            presenter?.validationFaild()
//        }
    }
    
    func addData(email: String, password: String) {
        print("ss")
        let user = User(email: email,Password: password)
        users.users.append(user)
        print(self.users.users[0].email ) 
    }
}
