//
//  BusArrivalInfoOnStationViewModel.swift
//  Study_Bus2020
//
//  Created by 김지섭 on 2020/01/18.
//  Copyright © 2020 kimjiseob. All rights reserved.
//

import Foundation

class BusArrivalInfoOnStationViewModel: NSObject, BusParserDelegate, BusDataSource {
    func searchData(text: String) {
    }
    
    
    var objectList: [Any?] {
        return self.list
    }
    
    var data: Data
    var parserKey: String?
    var dataParser: XMLParser
    var item: BusArrivalInfoOnStatioin = .init()
    var list: [BusArrivalInfoOnStatioin] = []
    
    init(data: Data) {
        self.data = data
        self.dataParser = XMLParser(data: self.data)
    }
    
    func parser() {
        self.dataParser.delegate = self
        self.dataParser.parse()
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
        case "rtNm":
            self.item.rtNm = string
        case "stationNm1":
            self.item.stationNm1 = string
        case "stationNm2":
            self.item.stationNm2 = string
        case "arrmsg1":
            self.item.arrmsg1 = string
        case "arrmsg2":
            self.item.arrmsg2 = string
        default:
            break
        }
    }
    
}
