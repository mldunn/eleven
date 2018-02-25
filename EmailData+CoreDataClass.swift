//
//  EmailData+CoreDataClass.swift
//  ESContacts
//
//  Created by michael dunn on 2/24/18.
//  Copyright © 2018 michael dunn. All rights reserved.
//
//

import Foundation
import CoreData

@objc(EmailData)
public class EmailData: NSManagedObject {

    var isValid:Bool {
        get {
            return Util.isNonEmptyFieldValue(value)
        }
    }
    
    func parse(data: NSDictionary) {
        value = data["value"] as? String ?? ""
        type = data["type"] as? String ?? ""
    }
    
    func dump() {
        Logger.log("type [\(type ?? "") ]")
        Logger.log("value [\(String(describing: value))]")
    }
    
}
