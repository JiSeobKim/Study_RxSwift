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
    
    // MARK: -  버스 정류장 리스트 By 키워드
    static func getBusStationInfoList(keyword: String) -> Single<[BusStationInfoByKeyword]> {
        return Single.create { (single) -> Disposable in
            
            let network = NetworkUtil.stationListByKeyword(keyword)
            
            network.request { (data) in
                let strData = String(data: data, encoding: .utf8)
                
                guard let cData = strData?.replacingOccurrences(of: "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>", with: "").data(using: .utf8) else {
                    single(.error(BusAPIError.invalidData))
                    return
                }
                
                let decoder = XMLDecoder()
                
                do {
                    let result = try decoder.decode(PXMLBusStationInfoByKeyword.self, from: cData)
                    
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
    
    // MARK: - 정류장 리스트 by 버스 루트
    static func getBusStationInfoList(routeId: String) -> Single<[BusStationInfoByRouteID]> {
        return Single.create { (single) -> Disposable in
            let network = NetworkUtil.stationListByBus(routeid: routeId)
            
            network.request { (data) in
                let strData = String(data: data, encoding: .utf8)
                
                guard let cData = strData?.replacingOccurrences(of: "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>", with: "").data(using: .utf8) else {
                    single(.error(BusAPIError.invalidData))
                    return
                }
                
                let decoder = XMLDecoder()
                
                do {
                    let result = try decoder.decode(PXMLBusStationInfoByRouteID.self, from: cData)
                    
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
    
    // MARK: -  버스 정류장 리스트 By 정류장 번호
    static func getBusList(id: String) -> Single<[BusStationInfoByID]> {
        return Single.create { (single) -> Disposable in
            
            let network = NetworkUtil.busListByStationID(id)
            
            network.request { (data) in
                let strData = String(data: data, encoding: .utf8)
                
                guard let cData = strData?.replacingOccurrences(of: "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>", with: "").data(using: .utf8) else {
                    single(.error(BusAPIError.invalidData))
                    return
                }
                
                let decoder = XMLDecoder()
                
                do {
                    let result = try decoder.decode(PXMLBusStationInfoByID.self, from: cData)
                    
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
    
    // MARK: -  버스 리스트 By 버스 번호
    static func getBusList(num: String) -> Single<[BusInfomation]> {
        return Single.create { (single) -> Disposable in
            let network = NetworkUtil.busListByNumber(num)
            
            network.request { (data) in
                let strData = String(data: data, encoding: .utf8)
                
                guard let cData = strData?.replacingOccurrences(of: "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>", with: "").data(using: .utf8) else {
                    single(.error(BusAPIError.invalidData))
                    return
                }
                
                let decoder = XMLDecoder()
                
                do {
                    let result = try decoder.decode(PXMLBusInfomation.self, from: cData)
                    
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
