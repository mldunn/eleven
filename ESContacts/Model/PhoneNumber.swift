//
//  Phone.swift
//  ESContacts
//
//  Created by michael dunn on 2/19/18.
//  Copyright © 2018 michael dunn. All rights reserved.
//

import Foundation


class PhoneNumber {
    var value: String
    var type: String
    var id: String
    
    init() {
        id = UUID().uuidString
        type = ""
        value = ""
    }
    
    init(clone: PhoneNumber) {
        id = clone.id
        type = clone.type
        value = clone.value
    }
    
    init(data: NSDictionary) {
        value = data["value"] as? String ?? ""
        type = data["type"] as? String ?? "home"
        id =  UUID().uuidString
    }
    
    var formatted: String {
        get {
            
            guard value.count > 9 else {
                return value
            }
            
            let areaCode = "(\(value.prefix(3))) "
            let suffix = value.suffix(4)
            
            let part1 = value[value.index(value.startIndex, offsetBy: 3)...value.index(value.startIndex, offsetBy: 5)]
            
            return areaCode + part1 + "-" + suffix
        }
    }
    
   
    
}
