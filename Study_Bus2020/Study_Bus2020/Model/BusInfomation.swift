//
//  BusListByNumber.swift
//  Study_Bus2020
//
//  Created by 김지섭 on 2020/01/25.
//  Copyright © 2020 kimjiseob. All rights reserved.
//

import Foundation


struct BusInfomation {
    var busRouteId: String?     // 100100055
    var busRouteNm: String?     // 340
    var corpNm: String?         // 서울승합  02-429-3104
    var edStationNm: String?    // 강남역
    var firstBusTm: String?     // 20200125043000
    var firstLowTm: String?     // 20151125043500
    var lastBusTm: String?      // 20200125231000
    var lastBusYn: String?
    var lastLowTm: String?      // 20150717231000
    var length: String?         // 41.1
    var routeType: String?      // 3
    var stStationNm: String?    // 강동공영차고지
    var term: String?           //  7
    
    init() {
        self.busRouteId = nil
        self.busRouteNm = nil
        self.corpNm = nil
        self.edStationNm = nil
        self.firstBusTm = nil
        self.firstLowTm = nil
        self.lastBusTm = nil
        self.lastBusYn = nil
        self.lastLowTm = nil
        self.length = nil
        self.routeType = nil
        self.stStationNm = nil
        self.term = nil
    }
}
