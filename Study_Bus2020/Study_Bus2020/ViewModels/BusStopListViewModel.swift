//
//  ParserBusStopList.swift
//  Study_Bus2020
//
//  Created by 김지섭 on 2020/01/18.
//  Copyright © 2020 kimjiseob. All rights reserved.
//

import Foundation
import RxSwift

class BusStopListViewModel: AddBusDataSource {
    
    var bag = DisposeBag()
    var objectList: [Any?] {
        return self.busStopList
    }
    
    private var busStopList: [BusStopListItem] = []
    
    func searchData(text: String) -> Completable {
        
        return .create { (completable) -> Disposable in
            let result = BusAPIClient.getBusStationInfoList(keyword: text)
            
            result.subscribe(onSuccess: { [weak self] (list) in
                guard let self = self else { return }
                self.busStopList = list
                
                completable(.completed)
            }) {(e) in
                completable(.error(e))
            }.disposed(by: self.bag)
            
            return Disposables.create()
        }
    }
}
