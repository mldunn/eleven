//
//  ContactData+CoreDataClass.swift
//  ESContacts
//
//  Created by michael dunn on 2/21/18.
//  Copyright © 2018 michael dunn. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

@objc(ContactData)
public class ContactData: NSManagedObject {
   
    //
    // initalize from JSON
    //
    func parse(data: NSDictionary, managedContext: NSManagedObjectContext) {
    
        firstName = data["firstName"] as? String
        lastName = data["lastName"] as? String
        company = data["company"] as? String
        id = data["contactID"] as? String ?? UUID().uuidString
        if let addresses = data["address"] as? NSArray {
            for item in addresses {
                if let ajson = item as? NSDictionary {
                    let addr = AddressData(context: managedContext)
                    addr.parse(data: ajson)
                    addToAddressItems(addr)
                }
            }
        }
        
        if let phones = data["phone"] as? NSArray {
            for item in phones {
                if let pjson = item as? NSDictionary {
                    let phone = PhoneData(context: managedContext)
                    phone.parse(data: pjson)
                    addToPhoneItems(phone)
                }
            }
        }
      
    }
    
    override public func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(firstName) ||  keyPath == #keyPath(lastName) ||  keyPath == #keyPath(company) {
            getSortInfo()
        }
    }
    
    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
        addObserver(self, forKeyPath: #keyPath(firstName), options: [.new], context: nil)
        addObserver(self, forKeyPath: #keyPath(lastName), options: [.new], context: nil)
        addObserver(self, forKeyPath: #keyPath(company), options: [.new], context: nil)
    }
    
    convenience init() {
     
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate  {
            let managedContext = appDelegate.persistentContainer.viewContext
            self.init(context: managedContext)
            id = UUID().uuidString
        }
        else {
            self.init()
        }
    }
    
    
    /*
    public func copy(with zone: NSZone? = nil) -> Any {
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return NSNull()
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let cd = ContactData(context: managedContext)
        
        cd.firstName = firstName
        cd.lastName = lastName
        cd.company = company
        cd.sectionKey = sectionKey
        cd.sortIndex = sortIndex
        cd.sortName = sortName
        cd.id = id
        
        if let items = addressItems {
            cd.addToAddressItems(items)
        }
        if let items = phoneItems {
            cd.addToPhoneItems(items)
        }
       
        return cd
       
    }
    */
    
    func getSortInfo() {
        // store the sort info here
        var index: Int32 = 0
        var name = ""
        if let ls = lastName, !ls.isEmpty  {
            name = ls + " "
            
            if let fn = firstName  {
                index = Int32(fn.count + 1)
            }
        }
            
        // add the first name in case last names are equal
        if let fs = firstName {
            name += fs
        }
        if name.isEmpty {
            if let c = company {
                name = c
            }
        }
        
        sectionKey = letterKey
        sortIndex = index
        sortName = name
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
    
    var letterKey: String {
        
        get {
            var initial = ""
            if let ls = lastName, !ls.isEmpty {
                initial = String(ls.prefix(1))
            }
            
            if (initial.isEmpty) {
                if let fs = firstName, !fs.isEmpty {
                    initial = String(fs.prefix(1))
                }
                if (initial.isEmpty) {
                    if let c = company, !c.isEmpty {
                        initial = String(c.prefix(1))
                    }
                }
            }
            if initial.isAlpha() {
                return initial.uppercased()
            }
            else {
                return "#"
            }
        }
    }
    
    var initials: String {
        
        get {
            var val = "", fi = "", li = ""
            
            if let fs = firstName, !fs.isEmpty {
               
                fi = String(fs.prefix(1))
            }
            if let ls = lastName, !ls.isEmpty {
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
    
  
    func getPhoneByIndex(_ index: Int) -> PhoneData? {
        
        var item: PhoneData?
        if let items = phoneItems {
            let arr = Array(items)
            
            guard index >= 0 && index < arr.count else {
                return nil
            }
        
            item = arr[index] as? PhoneData
            
        }
        return item
    }
    
    func getAddressByIndex(_ index: Int) -> AddressData? {
        var item: AddressData?
        if let items = addressItems {
            let arr = Array(items)
            
            guard index >= 0 && index < arr.count else {
                return nil
            }
            
            item = arr[index] as? AddressData
            
        }
        return item
    }
    
    func addPhone() -> Int {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate  {
            let managedContext = appDelegate.persistentContainer.viewContext
            let phone = PhoneData(context: managedContext)
            addToPhoneItems(phone)
        }
        dumpSet(phoneItems)
        return phoneCount
    }
    
    func addAddress() -> Int {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate  {
            let managedContext = appDelegate.persistentContainer.viewContext
            let address = AddressData(context: managedContext)
            addToAddressItems(address)
        }
        return addressCount
    }
    
    var phoneCount: Int {
        get {
            return phoneItems?.count ?? 0
        }
    }
    
    var isValid: Bool {
        return !( (firstName?.isEmpty ?? true) && (lastName?.isEmpty ?? true) && (company?.isEmpty ?? true) )
    }
    
    var addressCount: Int {
        get {
            return addressItems?.count ?? 0
        }
    }
    
    func sanitize() {
        if let set = phoneItems {
            let items = Array(set)
            var invalidItems = [PhoneData]()
            for item in items {
                
                if let dataItem = item as? PhoneData, !dataItem.isValid {
                    invalidItems.append(dataItem)
                }
            }
            for ii in invalidItems {
                removeFromPhoneItems(ii)
            }
            
        }
        if let set = addressItems {
            let items = Array(set)
            var invalidItems = [AddressData]()
            for item in items {
                
                if let dataItem = item as? AddressData, !dataItem.isValid {
                    invalidItems.append(dataItem)
                }
            }
            
            for ii in invalidItems {
                removeFromAddressItems(ii)
            }
        }
        
        
    }
    
    
    func dump() {
        Logger.log("id [\(id)]")
        Logger.log("firstname [\(firstName)]")
        Logger.log("lastname [\(lastName)]")
        Logger.log("company [\(company)]")
        Logger.log("sortKey [\(sectionKey)]")
        Logger.log("sortName [\(sortName)]")
        dumpSet(phoneItems)
        dumpSet(addressItems)
    }
    func dumpSet(_ set: NSOrderedSet?) {
        if let items = set {
            let arr = Array(items)
            var i = 0
            for item in arr {
                if let pi = item as? PhoneData {
                    Logger.log("PhoneItem \(i)")
                    pi.dump()
                }
                else if let ai = item as? AddressData {
                    Logger.log("AddressItem \(i)")
                    ai.dump()
                }
                i += 1
            }
        }
    }
}
