//
//  ContactData+CoreDataProperties.swift
//  ESContacts
//
//  Created by michael dunn on 2/21/18.
//  Copyright © 2018 michael dunn. All rights reserved.
//
//

import Foundation
import CoreData


extension ContactData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ContactData> {
        return NSFetchRequest<ContactData>(entityName: "ContactData")
    }

    @NSManaged public var company: String?
    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var sectionKey: String?
    @NSManaged public var sortIndex: Int32
    @NSManaged public var sortName: String?
    @NSManaged public var id: String?
    @NSManaged public var addressItems: NSSet?
    @NSManaged public var phoneItems: NSSet?

}

// MARK: Generated accessors for addressItems
extension ContactData {

    @objc(addAddressItemsObject:)
    @NSManaged public func addToAddressItems(_ value: AddressData)

    @objc(removeAddressItemsObject:)
    @NSManaged public func removeFromAddressItems(_ value: AddressData)

    @objc(addAddressItems:)
    @NSManaged public func addToAddressItems(_ values: NSSet)

    @objc(removeAddressItems:)
    @NSManaged public func removeFromAddressItems(_ values: NSSet)

}

// MARK: Generated accessors for phoneItems
extension ContactData {

    @objc(addPhoneItemsObject:)
    @NSManaged public func addToPhoneItems(_ value: PhoneData)

    @objc(removePhoneItemsObject:)
    @NSManaged public func removeFromPhoneItems(_ value: PhoneData)

    @objc(addPhoneItems:)
    @NSManaged public func addToPhoneItems(_ values: NSSet)

    @objc(removePhoneItems:)
    @NSManaged public func removeFromPhoneItems(_ values: NSSet)

}
