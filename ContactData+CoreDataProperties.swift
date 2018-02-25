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
    @NSManaged public var emailItems: NSOrderedSet?

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

// MARK: Generated accessors for emailItems
extension ContactData {

    @objc(insertObject:inEmailItemsAtIndex:)
    @NSManaged public func insertIntoEmailItems(_ value: EmailData, at idx: Int)

    @objc(removeObjectFromEmailItemsAtIndex:)
    @NSManaged public func removeFromEmailItems(at idx: Int)

    @objc(insertEmailItems:atIndexes:)
    @NSManaged public func insertIntoEmailItems(_ values: [EmailData], at indexes: NSIndexSet)

    @objc(removeEmailItemsAtIndexes:)
    @NSManaged public func removeFromEmailItems(at indexes: NSIndexSet)

    @objc(replaceObjectInEmailItemsAtIndex:withObject:)
    @NSManaged public func replaceEmailItems(at idx: Int, with value: EmailData)

    @objc(replaceEmailItemsAtIndexes:withEmailItems:)
    @NSManaged public func replaceEmailItems(at indexes: NSIndexSet, with values: [EmailData])

    @objc(addEmailItemsObject:)
    @NSManaged public func addToEmailItems(_ value: EmailData)

    @objc(removeEmailItemsObject:)
    @NSManaged public func removeFromEmailItems(_ value: EmailData)

    @objc(addEmailItems:)
    @NSManaged public func addToEmailItems(_ values: NSOrderedSet)

    @objc(removeEmailItems:)
    @NSManaged public func removeFromEmailItems(_ values: NSOrderedSet)

}
