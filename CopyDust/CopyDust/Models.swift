//
//  Models.swift
//  CopyDust
//
//  Created by 김지섭 on 2019/11/30.
//  Copyright © 2019 김지섭. All rights reserved.
//

import Foundation


struct StationWeatherInfo: Codable {
    var pm10Value: String?
    var pm25Value: String?
    var khaiGrade: String?
    var o3Grade: String?
    var coGrade: String?
    var dataTime: String?
    var no2Grade: String?
    var so2Grade: String?
    
    static func getDummyData() -> StationWeatherInfo {
        let data = StationWeatherInfo(pm10Value: "0", pm25Value: "0", khaiGrade: "0", o3Grade: "0", coGrade: "0", dataTime: "0", no2Grade: "0", so2Grade: "0")
        return data
    }
}

struct KoreaSiWeatherInfo: Codable {
    var dataTime: String?
    var daegu: String?
    var daejeon: String?
    var gangwon: String?
    var gwangju: String?
    var gyeongbuk: String?
    var gyeonggi: String?
    var gyeongnam: String?
    var incheon: String?
    var jeju: String?
    var jeonbuk: String?
    var jeonnam: String?
    var sejong: String?
    var seoul: String?
    var ulsan: String?
    
    
    
    static func getDummyData() -> KoreaSiWeatherInfo {
        let data = KoreaSiWeatherInfo(dataTime: "0", daegu: "0", daejeon: "0", gangwon: "0", gwangju: "0", gyeongbuk: "0", gyeonggi: "0", gyeongnam: "0", incheon: "0", jeju: "0", jeonbuk: "0", jeonnam: "0", sejong: "0", seoul: "0", ulsan: "0")
        return data
    }
    
    func convertToList() -> [(si: String, value: String?)] {
        var list: [(si: String, value: String?)] = []
        
        for row in SiType.allCases {
            
            switch row {
            case .daegu:
                list.append((si: row.rawValue, value: self.daegu))
            case .daejeon:
                list.append((si: row.rawValue, value: self.daejeon))
            case .gangwon:
                list.append((si: row.rawValue, value: self.gangwon))
            case .gwangju:
                list.append((si: row.rawValue, value: self.gwangju))
            case .gyeongbuk:
                list.append((si: row.rawValue, value: self.gyeongbuk))
            case .gyeonggi:
                list.append((si: row.rawValue, value: self.gyeonggi))
            case .gyeongnam:
                list.append((si: row.rawValue, value: self.gyeongnam))
            case .incheon:
                list.append((si: row.rawValue, value: self.incheon))
            case .jeju:
                list.append((si: row.rawValue, value: self.jeju))
            case .jeonbuk:
                list.append((si: row.rawValue, value: self.jeonbuk))
            case .jeonnam:
                list.append((si: row.rawValue, value: self.jeonnam))
            case .sejong:
                list.append((si: row.rawValue, value: self.sejong))
            case .seoul:
                list.append((si: row.rawValue, value: self.seoul))
            case .ulsan:
                list.append((si: row.rawValue, value: self.ulsan))
            }
        }
    
        return list
    }
}
