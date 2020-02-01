//
//  CoreDataClient.swift
//  Study_Bus2020
//
//  Created by 김지섭 on 2020/02/01.
//  Copyright © 2020 kimjiseob. All rights reserved.
//

import Foundation
import CoreData
import UIKit

struct CoreDataClient {
    enum CoreDataError: Error {
        case invalidFunctionParameter
    }
    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    static func saveBusData(routeId: String, routeNm: String, stationId: String, stationNm: String) throws {
        
        let con = context
        let entity = BusData.entity()
        
        let newData = BusData(entity: entity, insertInto: con)
        
        newData.routeId = routeId
        newData.stationId = stationId
        newData.addedDate = Date()
        newData.stationNm = stationNm
        newData.routeNm = routeNm
        
        try context.save()
    }
    
    static func fetchBusDatas() -> [BusData] {
        let con = context
        
        let request = BusData.fetchRequest() as NSFetchRequest <BusData>
        
        
        do {
            let data = try con.fetch(request)
            return data
            
        } catch {
            print("Error: \(error)")
            return []
        }
        
    }
}
