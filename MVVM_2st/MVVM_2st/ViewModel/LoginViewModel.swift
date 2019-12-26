//
//  LoginViewModel.swift
//  MVVM_2st
//
//  Created by 김지섭 on 2019/12/26.
//  Copyright © 2019 김지섭. All rights reserved.
//

import RxSwift
import RxCocoa

class LoginViewModel {
    let model: LoginModel = LoginModel()
    let disposeBag = DisposeBag()
    
    let emailIdViewModel = EmailIdViewModel()
    let passwordViewModel = PasswordViewModel()
    
    let isSuccess: BehaviorRelay<Bool> = .init(value: false)
    let isLoading: BehaviorRelay<Bool> = .init(value: false)
    let errorMsg: BehaviorRelay<String> = .init(value: "")
    
    func validateCredentials() -> Bool {
        return emailIdViewModel.validateCredentials() && passwordViewModel.validateCredentials()
    }
    
    func loginUser() {
        model.email = emailIdViewModel.data.value
        model.password = passwordViewModel.data.value
        
        self.isLoading.accept(true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.isLoading.accept(false)
            self?.isSuccess.accept(true)
        }
    }
}
