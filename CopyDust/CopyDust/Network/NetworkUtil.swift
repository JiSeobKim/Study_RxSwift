//
//  NetworkUtil.swift
//  CopyDust
//
//  Created by 김지섭 on 2019/11/30.
//  Copyright © 2019 김지섭. All rights reserved.
//

import Foundation

enum NetworkMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case put = "PUT"
}

enum NetworkType {
    case weatherInfoByStation
    case weatherInfoByItem(code: WeatherItemType)
    
    var serviceKey: String {
        return "VA9nd0hmRz%2Bc8ocwyUox2LPjwgptJdH5CixEPjQrZHQ%2Fo7gT6Fh6zmR%2Bx05bLCm%2B4zCU8QX%2BOSLtKW9eE3RRuw%3D%3D"
    }
    
    
    var url: URL? {
        var url = "http://openapi.airkorea.or.kr/openapi/services/rest"
        
        switch self {
        case .weatherInfoByStation:
            
            let etc = "/ArpltnInforInqireSvc/getMsrstnAcctoRltmMesureDnsty?stationName=종로구&dataTerm=DAILY&pageNo=1&numOfRows=10&ver=1.3"
            
            
            url += etc
            
        case .weatherInfoByItem(let code):
            let etc = "/ArpltnInforInqireSvc/getCtprvnMesureLIst?itemCode=\(code.rawValue)&dataGubun=HOUR&searchCondition=WEEK&pageNo=1&numOfRows=10"
        
            url += etc
        }
        // encoding
        if let encoded = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            url = encoded
        }
        
        // add key
        url += "&ServiceKey=\(self.serviceKey)"
        
        
        // to JSON
        url += "&_returnType=json"
        
        return URL(string: url)
    }
    
    
    func basicRequest(completeHandler: @escaping ((NSDictionary?)->())) {
        
        guard let url = self.url else { return }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = NetworkMethod.get.rawValue
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            guard
                data != nil,
                let json = try? JSONSerialization.jsonObject(with: data!, options: [])
                else { return }
            
            let dict = json as? NSDictionary
            completeHandler(dict)
        }
        
        task.resume()
    }
    
    
}
