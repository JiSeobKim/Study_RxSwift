//
//  BusStationInfoByRouteID.swift
//  Study_Bus2020
//
//  Created by 김지섭 on 2020/02/01.
//  Copyright © 2020 kimjiseob. All rights reserved.
//

import Foundation

struct PXMLBusStationInfoByRouteID: Codable {
    let header: ResponseHeader
    let body: BodyBusStationInfoByRouteID?
    
    
    private enum CodingKeys: String, CodingKey {
        case header = "msgHeader"
        case body = "msgBody"
    }
}

struct BodyBusStationInfoByRouteID: Codable {
    var itemList: [BusStationInfoByRouteID]?
}

struct BusStationInfoByRouteID: Codable, AddCellAvailable {
    
    var stId: String?
    var stNm: String?
    var arsId: String?
    
    
    
    var addCellTitle: String? {
        return self.stNm
    }
    
    var addCellSubtitle: String? {
        if arsId != nil {
            return "정류장 번호: \(arsId!)"
        } else {
            return nil
        }
    }
    
    
    
    
    init() {
        self.stId = nil
        self.stNm = nil
    }
    
    private enum CodingKeys: String, CodingKey {
        case arsId
        case stId = "station"
        case stNm = "stationNm"
    }
}
