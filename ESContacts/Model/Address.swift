//
//  Address.swift
//  ESContacts
//
//  Created by michael dunn on 2/19/18.
//  Copyright © 2018 michael dunn. All rights reserved.
//

import Foundation

class Address {
    var street1: String
    var street2: String
    var city: String
    var state: String
    var zip: String
    var id: String
    var type: String
    
   enum AddressField {
        case street1
        case street2
        case city
        case state
        case zip
        case type
    }
    
    init(data: NSDictionary) {
        street1 = data["street1"] as? String ?? ""
        street2 = data["street2"] as? String ?? ""
        city = data["city"] as? String ?? ""
        state = data["state"] as? String ?? ""
        zip = data["zipcode"] as? String ?? ""
        type = data["type"] as? String ?? "home"
        id = UUID().uuidString
    }
    
    init(clone: Address) {
        street1 = clone.street1
        street2 = clone.street2
        city = clone.city
        state = clone.state
        zip = clone.zip
        type = clone.type
        id = clone.id
    }
    
    init(type: String?) {
        id = UUID().uuidString
        self.type = type ?? "home"
        street1 = ""
        street2 = ""
        city = ""
        state = ""
        zip = ""
    }
   
    init() {
        id = UUID().uuidString
        type = "home"
        street1 = ""
        street2 = ""
        city = ""
        state = ""
        zip = ""
    }
    var blurb: String {
        get {
            var lines = ""
            lines.append(street1)
            lines.append("\n")
            if !street2.isEmpty {
                lines.append(street2)
                lines.append("\n")
            }
            lines.append("\(city) \(state) \(zip)")
            lines.append("\n\n")
            return lines
        }
    }
    
    func updateField(_ field: AddressField, value: String) {
        switch (field) {
        case .street1:
            street1 = value
        case .street2:
            street2 = value
        case .city:
            city = value
        case .state:
            state = value
        case .zip:
            zip = value
        case .type:
            type = value
        }
    }
}
