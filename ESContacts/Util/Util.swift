//
//  Util.swift
//  ESContacts
//
//  Created by michael dunn on 2/19/18.
//  Copyright © 2018 michael dunn. All rights reserved.
//

import Foundation


class Util {
    static func logException(_ function: String, error: Error) {
        print("\(function) exception with error: \(error.localizedDescription)")
    }
    
    static func logMessage(_ msg: String) {
        print("MSG: \(msg)")
    }
    
    static func checkImport(_ key: String) -> Bool {
        var needsImport: Bool = false
        if !UserDefaults.standard.bool(forKey: key) {
            needsImport = true
            UserDefaults.standard.set(true, forKey: key)
            UserDefaults.standard.synchronize()
        }
        return needsImport
    }
}



