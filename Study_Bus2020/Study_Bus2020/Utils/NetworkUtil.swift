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
    
    case getBusArrivedInfo
    case getBusLocationInfo
    case getBusStopInfo
    
    
    static var serviceKey = "esWE%2F4MoJGj6WtDlz9ohkyCCrWrrinS30s21ynJD2s9N2B5zv7Z4rGnQKg1QT84eaTOQSlgUTPpTzOYUU5MIRA%3D%3D"
    
    
    var baseURL: String {
        
        var base = "http://ws.bus.go.kr/api/rest"
        
        switch self {
        case .getBusStopInfo:
            base += "/stationinfo/getStationByName"
            break
        case .getBusArrivedInfo:
            break
        case .getBusLocationInfo:
            break
        }
        
        
        return ""
    }
    
    
}
