//
//  PhoneData+CoreDataProperties.swift
//  ESContacts
//
//  Created by michael dunn on 2/24/18.
//  Copyright © 2018 michael dunn. All rights reserved.
//
//

import Foundation
import CoreData


extension PhoneData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PhoneData> {
        return NSFetchRequest<PhoneData>(entityName: "PhoneData")
    }

    @NSManaged public var type: String?
    @NSManaged public var value: String?

}
