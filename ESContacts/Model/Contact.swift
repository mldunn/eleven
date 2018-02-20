//
//  Contact.swift
//  ESContacts
//
//  Created by michael dunn on 2/19/18.
//  Copyright © 2018 michael dunn. All rights reserved.
//

import Foundation


class Contact: Comparable {
    static func <(lhs: Contact, rhs: Contact) -> Bool {
        return lhs.sortName.localizedStandardCompare(rhs.sortName) == ComparisonResult.orderedAscending
    }
    
    static func ==(lhs: Contact, rhs: Contact) -> Bool {
        return lhs.sortName == rhs.sortName
    }
    
    static let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    
    var company: String?
    var firstName: String?
    var lastName: String?
    var id: String
    var phoneItems: [PhoneNumber] = []
    var addressItems: [Address] = []
    
    init() {
        id = UUID().uuidString
    }
    
    
    init(clone: Contact) {
        firstName = clone.firstName
        lastName = clone.lastName
        company = clone.company
        id = clone.id
        
      
            for item in clone.addressItems {
                let addr = Address(clone: item)
                addressItems.append(addr)
            }
        
        for item in clone.phoneItems {
            let phone = PhoneNumber(clone: item)
            phoneItems.append(phone)
        }
        
       
    }
    
    init(data: NSDictionary) {
        firstName = data["firstName"] as? String
        lastName = data["lastName"] as? String
        company = data["company"] as? String
        id = data["contactID"] as? String ?? UUID().uuidString
        
        if let addresses = data["address"] as? NSArray {
            for item in addresses {
                if let data = item as? NSDictionary {
                    let addr = Address(data: data)
                    addressItems.append(addr)
                }
            }
        }
        
        if let phones = data["phone"] as? NSArray {
            for item in phones {
                if let data = item as? NSDictionary {
                    let phone = PhoneNumber(data: data)
                    phoneItems.append(phone)
                }
            }
        }
        
    }
  
    var displayName: String {
        get {
            if let fn = firstName {
                if let ln = lastName {
                    return fn + " " + ln
                }
                else {
                    return fn
                }
            }
            else if let ln = lastName {
                return ln
            }
            else if let c = company {
                return c
            }
            
            return ""
        }
    }
    
   
    init(firstName: String?, lastName: String?, company: String?) {
        self.firstName = firstName
        self.lastName = lastName
        self.company = company
        id = UUID().uuidString
    }
    
    func addPhone(phone: PhoneNumber) {
        phoneItems.append(phone)
    }
    
    func addAddress(address: Address) {
        addressItems.append(address)
    }
 
    var letterKey: String {
        
        get {
            var initial = ""
            if let ls = lastName {
                initial = String(ls.prefix(1))
            }
                
            if (initial.isEmpty) {
                if let fs = firstName {
                    initial = String(fs.prefix(1))
                }
                if (initial.isEmpty) {
                    if let c = company {
                        initial = String(c.prefix(1))
                    }
                }
            }
            let u = initial.uppercased()
            if  Contact.letters.contains(u) {
                return u
            }
            else {
                return "#"
            }
        }
    }
    
    var initials: String {
        
        get {
            var val = "", fi = "", li = ""
            
            if let fs = firstName {
                fi = String(fs.prefix(1))
            }
            if let ls = lastName {
                li = String(ls.prefix(1))
            }
            val = fi + li
            
            if val.isEmpty {
                if let c = company {
                    val = String(c.prefix(1))
                }
            }
            return val.uppercased()
        }
    }
    
    var sortName: String {
        
        get {
            var name = ""
            if let ls = lastName {
                name = ls
            }
                
            if name.isEmpty {
                if let fs = firstName {
                    name = fs
                }
                if name.isEmpty {
                    if let c = company {
                        name = c
                    }
                }
            }
            return name
        }
    }
    
    var phoneCount: Int {
        get {
            return phoneItems.count
        }
    }
    
    var addressCount: Int {
        get {
            return addressItems.count
        }
    }
    
    func getPhoneByIndex(_ index: Int) -> PhoneNumber? {
        guard index >= 0 && index < phoneItems.count else {
            return nil
        }
        
        return phoneItems[index]
    }
    
    func getAddressByIndex(_ index: Int) -> Address? {
        guard index >= 0 && index < addressItems.count else {
            return nil
        }
        
        return addressItems[index]
    }
    
    func addPhone(_ phone: PhoneNumber) {
        phoneItems.append(phone)
    }
    
    func removePhone(_ id: String) {
        if let index = phoneItems.index(where: { $0.id == id }) {
            phoneItems.remove(at: index)
        }
    }
    
    func updatePhoneNumber(_ id: String, number: String) {
        if let phone = phoneItems.first(where: { $0.id == id }) {
            phone.value = number
        }
        
    }
    
    func updatePhoneType(_ id: String, type: String) {
        if let phone = phoneItems.first(where: { $0.id == id }) {
            phone.type = type
        }
    }
    
    
    func addAddress(_ address: Address) {
        addressItems.append(address)
    }
    
    func removeAddress(_ id: String) {
        if let index = addressItems.index(where: { $0.id == id }) {
            addressItems.remove(at: index)
        }
    }
    
 
    func updateAddressField(_ id: String, field: Address.AddressField, value: String) {
        if let address = addressItems.first(where: { $0.id == id }) {
            address.updateField(field, value: value)
        }
    }
}
