//
//  PojoClass.swift
//  assignmentApp
//
//  Created by Pranjal Singhai on 28/05/20.
//  Copyright © 2020 Capgemini. All rights reserved.
//

import Foundation

class PojoClass{
    var userName: String
    var lastName: String
    var email: String
    var phoneNumber: Int
    var address: String
    
    init(userName: String, lastName: String, email: String, phoneNumber: Int, address: String){
        self.userName = userName
        self.lastName = lastName
        self.email = email
        self.phoneNumber = phoneNumber
        self.address = address
    }
}

extension PojoClass{
    func isValidUserName() -> Bool {
        return (userName.count > 4 && userName != "NA" && !userName.contains(" ") )
    }
    
    func isValidLastName() -> Bool {
        return (lastName.count > 0 && lastName != "NA")
    }
    
    func isValidEmail() -> Bool {
        return (email.contains("@") && email.contains(".") && !email.contains(" "))
    }
    
    func isValidPhoneNumber() -> Bool {
        return (phoneNumber/1000 > 0)
    }
    
    func isValidAddress() -> Bool {
        return (address.count > 2)
    }
    
    func isDataValid() -> Bool {
        return (isValidUserName() && isValidLastName() && isValidEmail())
    }
    
}
