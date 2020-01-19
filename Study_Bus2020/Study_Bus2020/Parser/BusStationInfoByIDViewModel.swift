//
//  ParserBusStationInfoByID.swift
//  Study_Bus2020
//
//  Created by 김지섭 on 2020/01/18.
//  Copyright © 2020 kimjiseob. All rights reserved.
//

import Foundation
import RxCocoa

class BusStationInfoByIDViewModel: NSObject, BusParserDelegate, BusDataSource {

    var objectList: [Any?] {
        return self.list
    }
    
    var data: Data?
    var parserKey: String?
    var dataParser: XMLParser?
    var item: BusStationInfoByID = .init()
    var list: [BusStationInfoByID] = []
    var isChanged: BehaviorRelay<Bool> = .init(value: false)
    
    
    func parser() {
        guard self.dataParser != nil else { return }
        self.dataParser?.delegate = self
        self.dataParser?.parse()
    }
    func reset() {
        self.parserKey = nil
        self.item = .init()
    }
    
    func add() {
        self.list.append(self.item)
    }
    
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        self.parserKey = elementName
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "itemList" {
            self.add()
            self.reset()
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        switch self.parserKey {
        case "busRouteId":
            self.item.busRouteId = string
        case "busRouteNm":
            self.item.busRouteNm = string
        case "busRouteType":
            self.item.busRouteType = string
        case "firstBusTm":
            self.item.firstBusTm = string
        case "firstBusTmLow":
            self.item.firstBusTmLow = string
        case "lastBusTm":
            self.item.lastBusTm = string
        case "lastBusTmLow":
            self.item.lastBusTmLow = string
        case "length":
            self.item.length = string
        case "nextBus":
            self.item.nextBus = string
        case "stBegin":
            self.item.stBegin = string
        case "stEnd":
            self.item.stEnd = string
        case "term":
            self.item.term = string
        default:
            break
        }
    }
    
    func searchData(text: String) {
    }
}
