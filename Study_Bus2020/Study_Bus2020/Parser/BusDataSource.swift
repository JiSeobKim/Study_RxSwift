//
//  BusDataSource.swift
//  Study_Bus2020
//
//  Created by 김지섭 on 2020/01/18.
//  Copyright © 2020 kimjiseob. All rights reserved.
//

import Foundation


protocol BusDataSource {
    var objectList: [Any?] { get }
    
    func searchData(text: String) -> Void
}
