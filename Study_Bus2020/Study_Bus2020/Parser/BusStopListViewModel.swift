//
//  ParserBusStopList.swift
//  Study_Bus2020
//
//  Created by 김지섭 on 2020/01/18.
//  Copyright © 2020 kimjiseob. All rights reserved.
//

import Foundation

class BusStopListViewModel: NSObject, BusParserDelegate, BusDataSource {

    var objectList: [Any?] {
        return self.list
    }
    
    var data: Data
    var item: BusStopListItem = .init()
    var list: [BusStopListItem] = []
    var dataParser: XMLParser
    var parserKey: String?
    
    
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
        case "arsId":
            self.item.arsId = string
        case "posX":
            self.item.posX = string
        case "posY":
            self.item.posY = string
        case "stId":
            self.item.stId = string
        case "stNm":
            self.item.stNm = string
        case "tmX":
            self.item.tmX = string
        case "tmY":
            self.item.tmY = string
        default:
            break
        }
    }
    
    func searchData(text: String) {
        
    }
}
