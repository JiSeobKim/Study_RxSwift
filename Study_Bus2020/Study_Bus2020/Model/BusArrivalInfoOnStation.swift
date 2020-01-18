//
//  BusArrivalInfoOnStation.swift
//  Study_Bus2020
//
//  Created by 김지섭 on 2020/01/18.
//  Copyright © 2020 kimjiseob. All rights reserved.
//

import Foundation

struct BusArrivalInfoOnStatioin {
    var rtNm: String?
    var stationNm1: String?
    var stationNm2: String?
    var arrmsg1: String?
    var arrmsg2: String?
    
    init() {
        self.rtNm = nil
        self.stationNm1 = nil
        self.stationNm2 = nil
        self.arrmsg1 = nil
        self.arrmsg2 = nil
    }
}
