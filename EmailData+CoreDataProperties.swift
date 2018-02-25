//
//  EmailData+CoreDataProperties.swift
//  ESContacts
//
//  Created by michael dunn on 2/24/18.
//  Copyright © 2018 michael dunn. All rights reserved.
//
//

import Foundation
import CoreData


extension EmailData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EmailData> {
        return NSFetchRequest<EmailData>(entityName: "EmailData")
    }

    @NSManaged public var type: String?
    @NSManaged public var value: String?

}
