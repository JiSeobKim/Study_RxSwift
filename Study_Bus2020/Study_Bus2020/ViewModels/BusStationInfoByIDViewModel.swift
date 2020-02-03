//
//  ParserBusStationInfoByID.swift
//  Study_Bus2020
//
//  Created by 김지섭 on 2020/01/18.
//  Copyright © 2020 kimjiseob. All rights reserved.
//

import Foundation
import RxSwift

class BusStationInfoByIDViewModel: AddBusDataSource {
    
    var objectList: [Any?] {
        return self.busList
    }
    
    private var busList: [BusStationInfoByID] = []
    
    func searchData(text: String) -> Completable {
        
        return .create { (completable) -> Disposable in
            let result = BusAPIClient.getBusList(id: text)
            
            let disposable = result.subscribe(onSuccess: { [weak self] (list) in
                guard let self = self else { return }
                self.busList = list
                completable(.completed)
            }) {(e) in
                completable(.error(e))
            }
            
            return disposable
        }
    }
}
