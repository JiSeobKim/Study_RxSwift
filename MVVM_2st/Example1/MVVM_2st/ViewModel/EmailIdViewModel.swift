//
//  EmailIdViewModel.swift
//  MVVM_2st
//
//  Created by 김지섭 on 2019/12/26.
//  Copyright © 2019 김지섭. All rights reserved.
//

import RxCocoa

class EmailIdViewModel: ValidationViewModel {
    var errorMessage: String = "Please enter a valid Email Id"
    
    var data: BehaviorRelay<String> = .init(value: "")
    var errorValue: BehaviorRelay<String> = .init(value: "")
    
    func validateCredentials() -> Bool {
        guard validatePattern(text: data.value) else {
            errorValue.accept(self.errorMessage)
            return false
        }
        
//        errorValue.accept("")
        return true
    }
    
    func validatePattern(text : String) -> Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: text)
    }
    
}
