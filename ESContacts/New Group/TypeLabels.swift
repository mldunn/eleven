//
//  TypeLabels.swift
//  ESContacts
//
//  Created by michael dunn on 2/25/18.
//  Copyright © 2018 michael dunn. All rights reserved.
//

import Foundation


//
// This is a hard coded file that maps detail labels to the appropriate section
// used to display the list of available labels for a data item
//
// Ideally it would be better served as a database entity and add the ability to create on the fly
//

class TypeLabels {
    static let phone = ["home", "work", "mobile", "iPhone", "main", "school", "home fax", "work fax", "pager"]
    static let email =  ["home", "work", "iCloud", "school", "other"]
    static let address = ["home", "work", "school", "vacation", "other"]
    
    
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
