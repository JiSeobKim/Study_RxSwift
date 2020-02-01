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

    @NSManaged public var addedDate: Date?
    @NSManaged public var routeId: String?
    @NSManaged public var stationId: String?
    @NSManaged public var stationNm: String?
    @NSManaged public var routeNm: String?

}
