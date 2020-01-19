//
//  ParserBusStopList.swift
//  Study_Bus2020
//
//  Created by 김지섭 on 2020/01/18.
//  Copyright © 2020 kimjiseob. All rights reserved.
//

import Foundation

import RxCocoa

class BusStopListViewModel: NSObject, BusParserDelegate, BusDataSource {
    
    var objectList: [Any?] {
        return self.list
    }
    
    var data: Data? {
        didSet {
            guard data != nil else { return }
            self.dataParser = XMLParser(data: self.data!)
            self.parser()
        }
    }
    private var item: BusStopListItem = .init()
    private var list: [BusStopListItem] = []
    
    var isChanged: BehaviorRelay<Bool> = .init(value: false)
    
    var listObservable: BehaviorRelay<[BusStopListItem]> = .init(value: [])
    
    var dataParser: XMLParser?
    var parserKey: String?
    
    
    func parser() {
        guard self.dataParser != nil else { return }
        self.dataParser?.delegate = self
        self.dataParser?.parse()
    }
    func resetKeyword() {
        self.parserKey = nil
        self.item = .init()
    }
    
    func reset() {
        self.list = []
    }
    
    func add() {
        self.list.append(self.item)
    }
    
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        self.parserKey = elementName
    }

    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        switch elementName {
        case "itemList":
            self.add()
            self.resetKeyword()
        case "ServiceResult":
            self.isChanged.accept(true)
        default:
            break
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
        let network = NetworkUtil.busStopListByName(text: text)
        self.reset()
        
        network.request { (data) in
            self.data = data
        }
    }
}
