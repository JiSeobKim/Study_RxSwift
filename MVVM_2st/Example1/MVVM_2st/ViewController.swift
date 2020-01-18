//
//  ViewController.swift
//  MVVM_2st
//
//  Created by 김지섭 on 2019/12/26.
//  Copyright © 2019 김지섭. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    let viewModel = LoginViewModel()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        createViewModelBinding()
        createCallBacks()
    }
    
    
    private func createViewModelBinding() {
        self.emailTextField.rx
            .text
            .orEmpty
            .bind(to: self.viewModel.emailIdViewModel.data)
            .disposed(by: disposeBag)
        
        self.passwordTextField.rx
            .text
            .orEmpty
            .bind(to: self.viewModel.passwordViewModel.data)
            .disposed(by: disposeBag)
        
        self.loginButton.rx
            .tap
            .do(onNext: { [weak self] in
                self?.emailTextField.resignFirstResponder()
                self?.passwordTextField.resignFirstResponder()
            }).subscribe(onNext: { [weak self] in
                if self?.viewModel.validateCredentials() == true {
                    self?.viewModel.loginUser()
                }
            }).disposed(by: disposeBag)
        
        
    }
    
    private func createCallBacks() {
        // success
        self.viewModel.isSuccess.asObservable().skip(1)
            .bind { (value) in
                print("Successfull!!")
        }.disposed(by: disposeBag)
        
        self.viewModel.errorMsg.asObservable().skip(1)
            .bind { errorMessage in
                print(errorMessage)
        }.disposed(by: disposeBag)
    }


}

