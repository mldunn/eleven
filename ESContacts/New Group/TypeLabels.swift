//
//  TypeLabels.swift
//  ESContacts
//
//  Created by michael dunn on 2/25/18.
//  Copyright © 2018 michael dunn. All rights reserved.
//

import Foundation


//
// This is a hard coded files that maps detail labels to the approciate data section
// used to dispaly the list of available labels for a data item
// Ideally it would be better served as a database entity
//

class TypeLabels {
    static let phone = ["home", "work", "mobile", "iPhone", "main", "home fax", "work fax", "pager"]
    static let email =  ["home", "work", "iCloud", "other"]
    static let address = ["home", "work", "other"]
    
    
    static let sections = ["info", "phone","email","address"]
    
    static let labels: [String: [String]] = [
        "phone": phone,
        "email": email,
        "address": address
    ]
    
    static func defaultLabel(forType: String) -> String {
        if let labels = labels[forType] {
            return labels.first!
        }
        else {
            // use address for default
            return address.first!
        }
    }

    static func values(forType: String) -> [String] {
        if let labels = labels[forType] {
            return labels
        }
        else {
            // use address for default
            return address
        }
    }
}
