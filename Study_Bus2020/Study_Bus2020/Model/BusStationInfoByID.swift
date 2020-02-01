//
//  BusStationInfoByID.swift
//  Study_Bus2020
//
//  Created by 김지섭 on 2020/01/18.
//  Copyright © 2020 kimjiseob. All rights reserved.
//

import Foundation


struct PXMLBusStationInfoByID: Codable {
    let header: ResponseHeader
    let body: BodyBusStationInfoByID?
    
    
    private enum CodingKeys: String, CodingKey {
        case header = "msgHeader"
        case body = "msgBody"
    }
}

struct BodyBusStationInfoByID: Codable {
    var itemList: [BusStationInfoByID]?
}

struct BusStationInfoByID: Codable {
    var busRouteId: String?
    var busRouteNm: String?
    var busRouteType: String?
    var firstBusTm: String?
    var firstBusTmLow: String?
    var lastBusTm: String?
    var lastBusTmLow: String?
    var length: String?
    var nextBus: String?
    var stBegin: String?
    var stEnd: String?
    var term: String?
    
    init() {
        self.busRouteId = nil
        self.busRouteNm = nil
        self.busRouteType = nil
        self.firstBusTm = nil
        self.firstBusTmLow = nil
        self.lastBusTm = nil
        self.lastBusTmLow = nil
        self.length = nil
        self.nextBus = nil
        self.stBegin = nil
        self.stEnd = nil
        self.term = nil
    }
}
