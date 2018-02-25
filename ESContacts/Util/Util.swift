//
//  Util.swift
//  ESContacts
//
//  Created by michael dunn on 2/19/18.
//  Copyright © 2018 michael dunn. All rights reserved.
//

import Foundation


class Util {
   
    
    static func checkImport(_ key: String) -> Bool {
        var needsImport: Bool = false
        if !UserDefaults.standard.bool(forKey: key) {
            needsImport = true
            UserDefaults.standard.set(true, forKey: key)
            UserDefaults.standard.synchronize()
        }
        return needsImport
    }
    
    
    static func isNonEmptyFieldValue(_ value: String?) -> Bool {
        if let val = value {
            return !val.isEmpty
        }
        return false
    }
}



