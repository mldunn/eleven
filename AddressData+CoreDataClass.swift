//
//  AddressData+CoreDataClass.swift
//  ESContacts
//
//  Created by michael dunn on 2/21/18.
//  Copyright © 2018 michael dunn. All rights reserved.
//
//

import Foundation
import CoreData

@objc(AddressData)
public class AddressData: NSManagedObject {

    enum AddressField {
        case street1
        case street2
        case city
        case state
        case zip
        case type
    }
    
    var isValid: Bool {
        get {
            return Util.isNonEmptyFieldValue(street1)
                || Util.isNonEmptyFieldValue(street2)
                    || Util.isNonEmptyFieldValue(city)
                    || Util.isNonEmptyFieldValue(state)
                    || Util.isNonEmptyFieldValue(zipcode)
                  //  || Util.isNonEmptyFieldValue(country)
        }
    }
    
    func parse(data: NSDictionary) {
        street1 = data["street1"] as? String ?? ""
        street2 = data["street2"] as? String ?? ""
        city = data["city"] as? String ?? ""
        state = data["state"] as? String ?? ""
        zipcode = data["zipcode"] as? String ?? ""
        type = data["type"] as? String ?? "home"
    }
    
    var blurb: String {
        get {
            var lines = ""
            if let s1 = street1, !s1.isEmpty {
                lines.append(s1)
                lines.append("\n")
            }
            if let s2 = street2, !s2.isEmpty {
                lines.append(s2)
                lines.append("\n")
            }
            if let c = city {
                lines.append(c)
                lines.append(" ")
            }
            if let s = state {
                lines.append(s)
                lines.append(" ")
            }
            if let z = zipcode {
                lines.append(z)
                lines.append(" ")
            }
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
            zipcode = value
        case .type:
            type = value
        }
    }
    
    func dump() {
        Logger.log("street1 [\(street1)]")
        Logger.log("street2 [\(street2)]")
        Logger.log("city [\(city)]")
        Logger.log("state [\(state)]")
        Logger.log("zipcode [\(zipcode)]")
        Logger.log("type [\(type)]")

    }
}
