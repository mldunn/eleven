//
//  TypeLabels.swift
//  ESContacts
//
//  Created by michael dunn on 2/25/18.
//  Copyright © 2018 michael dunn. All rights reserved.
//

import Foundation

class TypeLabels {
    static let phone = ["home", "work", "mobile", "iPhone", "main", "home fax", "work fax", "pager"]
    static let email =  ["home", "work", "iCloud", "other"]
    static let address = ["home", "work", "other"]
    
    
    static let types = ["phone","email","address"]
    
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
