//
//  BusListByNumberViewModel.swift
//  Study_Bus2020
//
//  Created by 김지섭 on 2020/01/25.
//  Copyright © 2020 kimjiseob. All rights reserved.
//

import Foundation
import RxSwift

class BusListByNumberViewModel: AddBusDataSource {

    var objectList: [Any?] {
        return self.busInfoList
    }
    
    private var busInfoList: [BusInfomation] = []
    
    func searchData(text: String) -> Completable {
        
        return .create { (completable) -> Disposable in
            let result = BusAPIClient.getBusList(num: text)
            
            let disposable = result.subscribe(onSuccess: { [weak self] (list) in
                guard let self = self else { return }
                self.busInfoList = list
                
                completable(.completed)
            }) {(e) in
                completable(.error(e))
            }
            
            return disposable
        }
    }
}

