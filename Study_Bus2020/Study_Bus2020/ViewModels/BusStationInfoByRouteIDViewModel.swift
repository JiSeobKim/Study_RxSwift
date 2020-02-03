//
//  BusStationInfoByRouteIDViewModel.swift
//  Study_Bus2020
//
//  Created by 김지섭 on 2020/02/01.
//  Copyright © 2020 kimjiseob. All rights reserved.
//

import Foundation
import RxSwift

class BusStationInfoByRouteIDViewModel: AddBusDataSource {
    
    
    var objectList: [Any?] {
        return self.busStopList
    }
    
    private var busStopList: [BusStationInfoByRouteID] = []
    
    func searchData(text: String) -> Completable {
        
        return .create { (completable) -> Disposable in
            let result = BusAPIClient.getBusStationInfoList(routeId: text)
            
            let disposable = result.subscribe(onSuccess: { [weak self] (list) in
                guard let self = self else { return }
                self.busStopList = list
                
                completable(.completed)
            }) {(e) in
                completable(.error(e))
            }
            
            return disposable
        }
    }
}
