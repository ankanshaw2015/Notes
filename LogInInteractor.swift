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
    let context = CoreDataStack.shared.context
    
    var presenter: LogInPresenterProtocol?
    let users = UserData()
    
    func validateData(email: String, password: String) {
//        let userData = users.users
//        if userData.count == 0{
//            presenter?.validationFaild()
//            return
//        }
//        for data in userData{
//            if data.email == email && data.Password == password{
//                print("success")
//                presenter?.validationSuccess(email: email)
//                return
//            }
//        }
//            presenter?.validationFaild()
        
        
        
//        if email == password{
//            presenter?.validationSuccess(email: email)
//        }
//        else{
//            presenter?.validationFaild()
//        }
        
        let users = NoteUser.fetchRequest()
        var items :[NoteUser] = []
        do{
            items = try context.fetch(users)
        }catch{
            
        }
        if items.isEmpty{
            presenter?.validationFaild()
            return
        }
        
        for data in items{
                    if data.email == email && data.password == password{
                        print("success")
                        presenter?.validationSuccess(email: email)
                        return
                    }
                }
                    presenter?.validationFaild()
                
    
    }
    
    func addData(email: String, password: String) {
        
        let user = NoteUser(context: self.context)
        user.email = email
        user.password = password
        do{
            try self.context.save()
        }catch{
            
        }
        presenter?.validationSuccess(email: email)
    }
}
