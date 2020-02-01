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
    
    
    static func saveBusData(route: String, station: String) throws {
        
        let newData = BusData(entity: BusData.entity(), insertInto: context)
        
        newData.busRouteId = route
        newData.stationId = station
        newData.addedTimeInterval = Double(CACurrentMediaTime())
        
        try context.save()
    }
}
