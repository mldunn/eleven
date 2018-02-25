//
//  ContactHelper.swift
//  ESContacts
//
//  Created by michael dunn on 2/20/18.
//  Copyright © 2018 michael dunn. All rights reserved.
//

import Foundation
import CoreData
import UIKit



class ContactHelper {
    
    static var WILDCARD: String = "#"
    
    static func importContact(json: NSDictionary) {
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let contact = ContactData(context: managedContext)
        contact.parse(data: json, managedContext: managedContext)
        
        
        do {
            try managedContext.save()
        }
        catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    
    static func importJSON() {
        
        do {
            
            if let file = Bundle.main.url(forResource:  "contacts", withExtension: "json") {
                
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let object = json as? [String: Any] {
                    if let items = object["contacts"] as? NSArray {
                        
                        for item in items  {
                            importContact(json: (item as? NSDictionary) ?? [:])
                        }
                    }
                    else {
                        Util.logMessage("JSON error")
                    }
                }
            }
            else {
                Util.logMessage("JSON file not found")
            }
        }
        catch {
            Util.logException("getTopicsFromBundle", error: error)
        }
    }
   
    
    static func deleteContact(_ contact: ContactData) {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        
        let managedContext = appDelegate.persistentContainer.viewContext
        managedContext.delete(contact)
        do {
            try managedContext.save()
            
        }
        catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
    }
    
    static func getContact(_  id: String) -> ContactData? {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return nil
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ContactData")
        
        do {
            fetchRequest.predicate = NSPredicate(format: "id = %@", id)
            
            
            let items = try managedContext.fetch(fetchRequest)
            return items.first as? ContactData
            
        }
        catch let error as NSError {
            Logger.error(error, message: "get contact")
        }
        return nil
        
    }
    
    
    
    // section management
    
    static var totalItems: Int {
        get {
            var count = 0
            guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
                    return 0
            }
            let managedContext = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<ContactData>(entityName: "ContactData")
            
            do {
                let items = try managedContext.fetch(fetchRequest)
                count = items.count
            }
            catch let error as NSError {
                Logger.error(error, message: "get totalItems")
            }
            return count
        }
    }
    
    static func letterKeys() -> [String] {
        
        var keys: [String] = []
        
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return []
        }
        do {
            let managedContext = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSDictionary>()
            
            fetchRequest.entity = NSEntityDescription.entity(forEntityName: "ContactData", in: managedContext)
            fetchRequest.returnsDistinctResults = true
            fetchRequest.propertiesToFetch = ["sectionKey"]
            fetchRequest.resultType = .dictionaryResultType
            let sortDescriptor = NSSortDescriptor(key: "sectionKey", ascending: true)
            fetchRequest.sortDescriptors = [sortDescriptor]
            let items = try managedContext.fetch(fetchRequest)
            
            // check for the wildcard and move it to the bottom of the list
            var wildcard: Bool = false
            for item in items {
                if let val = item.value(forKey: "sectionKey") as? String {
                    if val == ContactHelper.WILDCARD {
                        wildcard = true
                    }
                    else {
                        keys.append(val)
                    }
                }
            }
            if wildcard {
                keys.append(ContactHelper.WILDCARD)
            }
        }
        catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return keys
        
    }
    
    static func numberOfItems(letter: String) -> Int {
        if let items = itemsForKey(letter: letter) {
            return items.count
        }
        return 0
    }
    
    static func itemsForKey(letter: String) -> [NSManagedObject]? {
        
        var items: [NSManagedObject]?
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return []
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ContactData")
        
        do {
            fetchRequest.predicate = NSPredicate(format: "sectionKey = %@", letter)
            
            let sortDescriptor = NSSortDescriptor(key: "sortName", ascending: true)
            fetchRequest.sortDescriptors = [sortDescriptor]
            
            items = try managedContext.fetch(fetchRequest)
        }
        catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return items
    }
}

