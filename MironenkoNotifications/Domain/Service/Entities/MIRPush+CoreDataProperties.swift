//
//  MIRPush+CoreDataProperties.swift
//  MironenkoNotifications
//
//  Created by Mironenko Evgeniy on 6/3/20.
//  Copyright © 2020 Mironenko Evgeniy. All rights reserved.
//

import Foundation
import CoreData


extension MIRPush {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MIRPush> {
        return NSFetchRequest<MIRPush>(entityName: "MIRPush")
    }

    @NSManaged public var titleText: String?
    @NSManaged public var computedNumber: Int64
    @NSManaged public var isSilent: Bool
    @NSManaged public var receivedNumber: Int64
    @NSManaged public var receivedDate: Date?

}
