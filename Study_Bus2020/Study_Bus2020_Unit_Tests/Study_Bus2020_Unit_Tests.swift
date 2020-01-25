//
//  Study_Bus2020_Unit_Tests.swift
//  Study_Bus2020_Unit_Tests
//
//  Created by 김지섭 on 2020/01/25.
//  Copyright © 2020 kimjiseob. All rights reserved.
//

import XCTest
@testable import Study_Bus2020

class Study_Bus2020_Unit_Tests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAPI() {
        let a = NetworkUtil.busListByNumber("370")
        a.request { (<#Data#>) in
            <#code#>
        }
        
    
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.

        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
