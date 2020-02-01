//
//  BusStopListItem.swift
//  Study_Bus2020
//
//  Created by 김지섭 on 2020/01/18.
//  Copyright © 2020 kimjiseob. All rights reserved.
//

import Foundation

struct PXMLBusStopListItem: Codable {
    let header: ResponseHeader
    let body: BodyBusStopListItem?
    
    
    private enum CodingKeys: String, CodingKey {
        case header = "msgHeader"
        case body = "msgBody"
    }
}

struct BodyBusStopListItem: Codable {
    var itemList: [BusStopListItem]?
}

struct BusStopListItem: Codable {
    var arsId: String?
    var posX: String?
    var posY: String?
    var stId: String?
    var stNm: String?
    var tmX: String?
    var tmY: String?
    
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
