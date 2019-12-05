//
//  NetworkCollection.swift
//  CopyDust
//
//  Created by kimjiseob on 2019/12/04.
//  Copyright © 2019 김지섭. All rights reserved.
//

import Foundation

struct NetworkCollection {
    static func getStationWeatherInfo(completeHandler: @escaping ((StationWeatherInfo?)->())) {
        let apiType = NetworkType.weatherInfoByStation
        
        apiType.basicRequest { (dict) in
            guard
                let list = dict?["list"] as? [Any],
                let nowData = list.first,
                let jsonData = try? JSONSerialization.data(withJSONObject: nowData, options: [])
                else {
                    completeHandler(nil)
                    return
            }

            // Use Codable
            guard let object = try? JSONDecoder().decode(StationWeatherInfo.self, from: jsonData) else {
                completeHandler(nil)
                return
            }
            
            completeHandler(object)
        }
    }
    
    
    static func getKoreaSiWeetherInfo(itemCode: WeatherItemType, completeHandler: @escaping (([KoreaSiWeatherInfo]?)->())) {
        let apiType = NetworkType.weatherInfoByItem(code: itemCode)
        
        apiType.basicRequest { (dict) in
            guard let list = dict?["list"] as? [Any] else {
                completeHandler(nil)
                return
            }
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: list, options: [])
                let object = try JSONDecoder().decode([KoreaSiWeatherInfo].self, from: jsonData)
                completeHandler(object)
            } catch (let e) {
                print(e.localizedDescription)
                completeHandler(nil)
            }
        }
    }
}

