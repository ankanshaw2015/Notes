//
//  LogInIntity.swift
//  MyNote
//
//  Created by Yashom on 01/10/24.
//

import Foundation
class User{
    var email:String
    var Password:String
    init(email: String, Password: String) {
        self.email = email
        self.Password = Password
    }
    
}


class UserData{
    var users:[User] = []
}
