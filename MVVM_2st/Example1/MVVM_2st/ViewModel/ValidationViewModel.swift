//
//  ValidationViewModel.swift
//  MVVM_2st
//
//  Created by 김지섭 on 2019/12/26.
//  Copyright © 2019 김지섭. All rights reserved.
//
import RxCocoa
protocol ValidationViewModel {
    var errorMessage: String {get}
    
    var data: BehaviorRelay<String> {get set}
    var errorValue: BehaviorRelay<String> {get}
    
    func validateCredentials() -> Bool
    
}
