//
//  BusAPIClient.swift
//  Study_Bus2020
//
//  Created by 김지섭 on 2020/01/31.
//  Copyright © 2020 kimjiseob. All rights reserved.
//

import Foundation
import RxSwift
import XMLParsing

struct BusAPIClient {
    static func getBusStationInfoList(keyword: String) -> Single<[BusStopListItem]> {
        return Single.create { (single) -> Disposable in
            
            let network = NetworkUtil.busStopListByKeyword(keyword)
            
            network.request { (data) in
                let strData = String(data: data, encoding: .utf8)
                
                guard let cData = strData?.replacingOccurrences(of: "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>", with: "").data(using: .utf8) else {
                    single(.error(BusAPIError.invalidData))
                    return
                }
                
                let decoder = XMLDecoder()
                
                do {
                    let result = try decoder.decode(PXMLBusStopListItem.self, from: cData)
                    
                    guard result.header.headerCd != 4 else {
                        single(.error(BusAPIError.noResult))
                        return
                    }
                    
                    if let list = result.body?.itemList {
                        single(.success(list))
                    } else {
                        single(.error(BusAPIError.invalidData))
                    }
                    
                } catch {
                    single(.error(error))
                }
                
            }
            
            return Disposables.create()
        }
    }
    
    
}
