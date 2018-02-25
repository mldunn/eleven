//
//  PhoneData+CoreDataClass.swift
//  ESContacts
//
//  Created by michael dunn on 2/21/18.
//  Copyright © 2018 michael dunn. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

@objc(PhoneData)
public class PhoneData: NSManagedObject {
    
    
    
    var isValid:Bool {
        get {
            return Util.isNonEmptyFieldValue(value)
        }
    }
    
    func parse(data: NSDictionary) {
        value = data["value"] as? String ?? ""
        type = data["type"] as? String ?? TypeLabels.defaultLabel(forType: "phone")
   }
    
    var formatted: String {
        get {
            
            if let value = value {
                guard value.count > 9 else {
                    return value
                }
                
                let areaCode = "(\(value.prefix(3))) "
                let suffix = value.suffix(4)
                
                let part1 = value[value.index(value.startIndex, offsetBy: 3)...value.index(value.startIndex, offsetBy: 5)]
                
                return areaCode + part1 + "-" + suffix
            }
            else {
                return ""
            }
        }
    }
    
    func dump() {
        Logger.log("type [\(type ?? "") ]")
        Logger.log("value [\(String(describing: value))]")
    }
}
