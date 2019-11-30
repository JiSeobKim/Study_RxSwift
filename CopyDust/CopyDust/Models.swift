//
//  Models.swift
//  CopyDust
//
//  Created by 김지섭 on 2019/11/30.
//  Copyright © 2019 김지섭. All rights reserved.
//

import Foundation


struct WeatherInfo {
    var pm10Value: String?
    var pm25Value: String?
    var khaiGrade: String?
    var o3Grade: String?
    var coGrade: String?
    var dataTime: String?
    var no2Grade: String?
    var so2Grade: String?
    
    static func getDummyData() -> WeatherInfo {
        let data = WeatherInfo(pm10Value: "0", pm25Value: "0", khaiGrade: "0", o3Grade: "0", coGrade: "0", dataTime: "0", no2Grade: "0", so2Grade: "0")
        return data
    }
}
