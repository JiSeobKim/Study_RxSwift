//
//  BusStationInfoByKeyword.swift
//  Study_Bus2020
//
//  Created by 김지섭 on 2020/01/18.
//  Copyright © 2020 kimjiseob. All rights reserved.
//

import Foundation

struct PXMLBusStationInfoByKeyword: Codable {
    let header: ResponseHeader
    let body: BodyBusStationInfoByKeyword?
    
    
    private enum CodingKeys: String, CodingKey {
        case header = "msgHeader"
        case body = "msgBody"
    }
}

struct BodyBusStationInfoByKeyword: Codable {
    var itemList: [BusStationInfoByKeyword]?
}

struct BusStationInfoByKeyword: Codable, AddCellAvailable {
    
    var arsId: String?
    var posX: String?
    var posY: String?
    var stId: String?
    var stNm: String?
    var tmX: String?
    var tmY: String?
    
    var addCellTitle: String? {
        return self.stNm
    }
    
    var addCellSubtitle: String? {
        if self.arsId != nil {
            return "정류장 번호: \(self.arsId!)"
        } else {
            return nil
        }
    }
    
    init() {
        self.arsId = nil
        self.posX = nil
        self.posY = nil
        self.stId = nil
        self.stNm = nil
        self.tmX = nil
        self.tmY = nil
    }
}
