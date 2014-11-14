//
//  IataAirports.swift
//  PT1
//
//  Created by Noah Ludescher on 14.11.14.
//  Copyright (c) 2014 Noah Ludescher. All rights reserved.
//

import Foundation
import CoreData

class IataAirports: NSManagedObject {

    @NSManaged var iataCode: String
    @NSManaged var country: String
    @NSManaged var destination: String
    @NSManaged var lhAirport: NSNumber
    @NSManaged var createdAt: NSDate
    @NSManaged var objectId: String

}
