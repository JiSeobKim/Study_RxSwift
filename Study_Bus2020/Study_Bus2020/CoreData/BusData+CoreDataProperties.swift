//
//  BusData+CoreDataProperties.swift
//  Study_Bus2020
//
//  Created by 김지섭 on 2020/02/01.
//  Copyright © 2020 kimjiseob. All rights reserved.
//
//

import Foundation
import CoreData


extension BusData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BusData> {
        return NSFetchRequest<BusData>(entityName: "BusData")
    }

    @NSManaged public var busRouteId: String?
    @NSManaged public var stationId: String?
    @NSManaged public var addedTimeInterval: Double

}
