//
//  People.swift
//  PT1
//
//  Created by Noah Ludescher on 11.11.14.
//  Copyright (c) 2014 Noah Ludescher. All rights reserved.
//

import Foundation
import CoreData

class People: NSManagedObject {

    @NSManaged var playerName: String
    @NSManaged var score: NSNumber
    @NSManaged var updatedAt: NSDate
    @NSManaged var objectId: String
    @NSManaged var createdAt: NSDate

}
