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

    var isValid: Bool {
        get {
            return Util.isNonEmptyFieldValue(street1)
                || Util.isNonEmptyFieldValue(street2)
                    || Util.isNonEmptyFieldValue(city)
                    || Util.isNonEmptyFieldValue(state)
                    || Util.isNonEmptyFieldValue(zipcode)
        }
    }
    
    func parse(data: NSDictionary) {
        street1 = data["street1"] as? String ?? ""
        street2 = data["street2"] as? String ?? ""
        city = data["city"] as? String ?? ""
        state = data["state"] as? String ?? ""
        zipcode = data["zipcode"] as? String ?? ""
        type = data["type"] as? String ?? TypeLabels.defaultLabel(forType: "address")
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
            var citystatezip = ""
            if let c = city, !c.isEmpty {
                citystatezip.append(c)
                citystatezip.append(" ")
            }
            if let s = state, !s.isEmpty {
                citystatezip.append(s)
                citystatezip.append(" ")
            }
            if let z = zipcode, !z.isEmpty {
                citystatezip.append(z)
            }
            if !citystatezip.isEmpty {
                lines.append(citystatezip)
                lines.append("\n")
            }
            if let co = country, !co.isEmpty {
                lines.append(co)
            }
            lines.append("\n\n")
            return lines
        }
    }
    
    
    func dump() {
        Logger.log("street1 [\(String(describing: street1))]")
        Logger.log("street2 [\(String(describing: street2))]")
        Logger.log("city [\(String(describing: city))]")
        Logger.log("state [\(String(describing: state))]")
        Logger.log("zipcode [\(String(describing: zipcode))]")
        Logger.log("type [\(String(describing: type))]")

    }
}
