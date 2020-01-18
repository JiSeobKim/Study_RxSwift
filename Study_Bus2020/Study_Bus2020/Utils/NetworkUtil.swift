//
//  NetworkUtil.swift
//  Study_Bus2020
//
//  Created by kimjiseob on 2020/01/18.
//  Copyright © 2020 kimjiseob. All rights reserved.
//

import Foundation
import Alamofire



enum NetworkUtil {
    
    case busStopListByName(text: String)
    case busStopInfoByStationID(num: String)
    
    
    static var serviceKey = "esWE%2F4MoJGj6WtDlz9ohkyCCrWrrinS30s21ynJD2s9N2B5zv7Z4rGnQKg1QT84eaTOQSlgUTPpTzOYUU5MIRA%3D%3D"
    
    
    var baseURL: String {
        
        var base = "http://ws.bus.go.kr/api/rest"
        
        switch self {
        case .busStopListByName:
            base += "/stationinfo/getStationByName"
            
        case .busStopInfoByStationID:
            base += "/stationinfo/getRouteByStation"
        }
        
        return base
    }
    
    
    var queryParam: String {
        var query = ""
        
        switch self {
        case .busStopListByName(let text):
            query = "stSrch=\(text)"
        case .busStopInfoByStationID(let num):
            query = "arsId=\(num)"
        }
        query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        query += "&serviceKey=\(NetworkUtil.serviceKey)"
        
        return query
    }
    
    func request(complete: @escaping ((Data)->())) {
        let url = self.baseURL + "?" + self.queryParam
        
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseData { (response) in
            switch response.result {
            case .success(let result):
                print(result)
                complete(result)
            case .failure(let e):
                print(e.localizedDescription)
            }
        }
        
    }
    
    
}
