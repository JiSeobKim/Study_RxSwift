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
    // 버스 정류소 목록 정보 조회 by 검색어
    case busStopListByKeyword(_ text: String)
    // 정류소의 버스 목록 조회 by ID
    case stationBusListByStationID(_ id: String)
    // 버스 번호로 버스 리스트 검색
    case busListByNumber(_ num: String)
    
    
    static var serviceKey = "esWE%2F4MoJGj6WtDlz9ohkyCCrWrrinS30s21ynJD2s9N2B5zv7Z4rGnQKg1QT84eaTOQSlgUTPpTzOYUU5MIRA%3D%3D"
    
    
    var baseURL: String {
        
        var base = "http://ws.bus.go.kr/api/rest"
        
        switch self {
        case .busStopListByKeyword:
            base += "/stationinfo/getStationByName"
        case .stationBusListByStationID:
            base += "/stationinfo/getRouteByStation"
        case .busListByNumber:
            base += "/busRouteInfo/getBusRouteList"
        }
        
        return base
    }
    
    
    var queryParam: String {
        var query = ""
        
        switch self {
        case .busStopListByKeyword(let text):
            query = "stSrch=\(text)"
        case .stationBusListByStationID(let id):
            query = "arsId=\(id)"
        case .busListByNumber(let num):
            query = "strSrch=\(num)"
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
