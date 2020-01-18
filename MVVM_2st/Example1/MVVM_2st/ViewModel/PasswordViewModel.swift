//
//  PasswordViewModel.swift
//  MVVM_2st
//
//  Created by 김지섭 on 2019/12/26.
//  Copyright © 2019 김지섭. All rights reserved.
//
import RxCocoa

class PasswordViewModel: ValidationViewModel {
    var errorMessage: String = "Please enter a valid Password"
    var data: BehaviorRelay<String> = .init(value: "")
    var errorValue: BehaviorRelay<String> = .init(value: "")
    
    func validateCredentials() -> Bool {
        guard validateLength(text: data.value, size: (6,15)) else {
            errorValue.accept(errorMessage)
            return false
        }
        
        errorValue.accept("")
        return true
    }
    
    func validateLength(text: String, size: (min: Int, max: Int)) -> Bool {
        return (size.min...size.max).contains(text.count)
    }
    
    
}
