//
//  BusDataSource.swift
//  Study_Bus2020
//
//  Created by 김지섭 on 2020/01/18.
//  Copyright © 2020 kimjiseob. All rights reserved.
//

import Foundation
import RxCocoa

protocol BusDataSource {
    var objectList: [Any?] { get }
    
    var data: Data? {get set}
    var parserKey: String? {get set}
    var dataParser: XMLParser? {get set}
    var isChanged: BehaviorRelay<Bool> {get set}
    
    func searchData(text: String) -> Void
}
