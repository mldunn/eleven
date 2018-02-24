//
//  ContactData+CoreDataProperties.swift
//  ESContacts
//
//  Created by michael dunn on 2/24/18.
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
    @NSManaged public var id: String?
    @NSManaged public var lastName: String?
    @NSManaged public var sectionKey: String?
    @NSManaged public var sortIndex: Int32
    @NSManaged public var sortName: String?
    @NSManaged public var addressItems: NSOrderedSet?
    @NSManaged public var phoneItems: NSOrderedSet?

}

// MARK: Generated accessors for addressItems
extension ContactData {

    @objc(insertObject:inAddressItemsAtIndex:)
    @NSManaged public func insertIntoAddressItems(_ value: AddressData, at idx: Int)

    @objc(removeObjectFromAddressItemsAtIndex:)
    @NSManaged public func removeFromAddressItems(at idx: Int)

    @objc(insertAddressItems:atIndexes:)
    @NSManaged public func insertIntoAddressItems(_ values: [AddressData], at indexes: NSIndexSet)

    @objc(removeAddressItemsAtIndexes:)
    @NSManaged public func removeFromAddressItems(at indexes: NSIndexSet)

    @objc(replaceObjectInAddressItemsAtIndex:withObject:)
    @NSManaged public func replaceAddressItems(at idx: Int, with value: AddressData)

    @objc(replaceAddressItemsAtIndexes:withAddressItems:)
    @NSManaged public func replaceAddressItems(at indexes: NSIndexSet, with values: [AddressData])

    @objc(addAddressItemsObject:)
    @NSManaged public func addToAddressItems(_ value: AddressData)

    @objc(removeAddressItemsObject:)
    @NSManaged public func removeFromAddressItems(_ value: AddressData)

    @objc(addAddressItems:)
    @NSManaged public func addToAddressItems(_ values: NSOrderedSet)

    @objc(removeAddressItems:)
    @NSManaged public func removeFromAddressItems(_ values: NSOrderedSet)

}

// MARK: Generated accessors for phoneItems
extension ContactData {

    @objc(insertObject:inPhoneItemsAtIndex:)
    @NSManaged public func insertIntoPhoneItems(_ value: PhoneData, at idx: Int)

    @objc(removeObjectFromPhoneItemsAtIndex:)
    @NSManaged public func removeFromPhoneItems(at idx: Int)

    @objc(insertPhoneItems:atIndexes:)
    @NSManaged public func insertIntoPhoneItems(_ values: [PhoneData], at indexes: NSIndexSet)

    @objc(removePhoneItemsAtIndexes:)
    @NSManaged public func removeFromPhoneItems(at indexes: NSIndexSet)

    @objc(replaceObjectInPhoneItemsAtIndex:withObject:)
    @NSManaged public func replacePhoneItems(at idx: Int, with value: PhoneData)

    @objc(replacePhoneItemsAtIndexes:withPhoneItems:)
    @NSManaged public func replacePhoneItems(at indexes: NSIndexSet, with values: [PhoneData])

    @objc(addPhoneItemsObject:)
    @NSManaged public func addToPhoneItems(_ value: PhoneData)

    @objc(removePhoneItemsObject:)
    @NSManaged public func removeFromPhoneItems(_ value: PhoneData)

    @objc(addPhoneItems:)
    @NSManaged public func addToPhoneItems(_ values: NSOrderedSet)

    @objc(removePhoneItems:)
    @NSManaged public func removeFromPhoneItems(_ values: NSOrderedSet)

}
