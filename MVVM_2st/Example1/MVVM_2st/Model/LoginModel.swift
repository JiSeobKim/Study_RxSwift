//
//  LoginModel.swift
//  MVVM_2st
//
//  Created by 김지섭 on 2019/12/26.
//  Copyright © 2019 김지섭. All rights reserved.
//

class LoginModel {
    var email = ""
    var password = ""
    
    convenience init(email: String, password: String) {
        self.init()
        self.email = email
        self.password = password
    }
}
