//
//  ContactManager.swift
//  ESContacts
//
//  Created by michael dunn on 2/19/18.
//  Copyright © 2018 michael dunn. All rights reserved.
//

import Foundation

class ContactsManager {
    
    init() {
        for c in Contact.letters {
            contacts[String(c)] = []
        }
    }
    
    var contacts: [String: [Contact]] = [:]
    
    var count: Int {
        get {
            var c = 0
            for (_ , items) in contacts {
                c += items.count
            }
            return c
        }
    }
    
    //xx
    func load() -> Int {
        return importJSON()
    }
    
    func importJSON() -> Int {
        
        do {
            
            if let file = Bundle.main.url(forResource:  "contacts", withExtension: "json") {
                
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let object = json as? [String: Any] {
                    if let items = object["contacts"] as? NSArray {
                        
                        for item in items  {
                            let contact = Contact(data: (item as? NSDictionary) ?? [:])
                            addContact(contact)
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
        
        return contacts.count;
    }
    
    func addContact(_ contact: Contact) {
        let key = contact.letterKey
        if contacts[key] == nil {
            contacts[key] = []
        }
        contacts[key]?.append(contact)
        contacts[key]?.sort(by: <)
    }
    
    func deleteContact(_ contact: Contact) {
        let key = contact.letterKey;
        if let c = contacts[key] {
        
            if let index =  c.index(where: { $0.id == contact.id }) {
                contacts[key]?.remove(at: index)
            }
        }
    }
    
    func updateContact(_ contact: Contact) {
        let key = contact.letterKey;
        if let c = contacts[key] {
            
            if let index = c.index(where: { $0.id == contact.id }) {
                contacts[key]?.remove(at: index)
                contacts[key]?.insert(contact, at: index)
                
            }
            else {
               addContact(contact)
            }
        }
        else {
            addContact(contact)
        }
        contacts[key]?.sort(by: <)
    }
    
    
    // section management
    
    func letterKeys() -> [String] {
        
        var wildcard = false
        var keys = [String]()
        for (key, items) in contacts {
            
            if items.count > 0 {
                if  key == "#" {
                    wildcard = true
                }
                else {
                    keys.append(key)
                }
            }
        }
        keys.sort()
        if wildcard {
            keys.append("#")
        }
        return keys
    }
    
    func numberOfItems(letter: String) -> Int {
        
        if let c = contacts[letter] {
            return c.count
        }
        
        return 0
    }
    
    func itemsForKey(letter: String) -> [Contact]? {
        return contacts[letter]
    }
}
