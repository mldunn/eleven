//
//  AddressData+CoreDataProperties.swift
//  ESContacts
//
//  Created by michael dunn on 2/21/18.
//  Copyright © 2018 michael dunn. All rights reserved.
//
//

import Foundation
import CoreData


extension AddressData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AddressData> {
        return NSFetchRequest<AddressData>(entityName: "AddressData")
    }

    @NSManaged public var city: String?
    @NSManaged public var country: String?
    @NSManaged public var state: String?
    @NSManaged public var street1: String?
    @NSManaged public var street2: String?
    @NSManaged public var type: String?
    @NSManaged public var zipcode: String?

}
