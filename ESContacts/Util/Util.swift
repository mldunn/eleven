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
    
    static func checkOnetimeKey(_ key: String) -> Bool {
        var keyFound: Bool = true
        if (UserDefaults.standard.string(forKey: key) == nil) {
            keyFound = false
            UserDefaults.standard.set("true", forKey: key)
            UserDefaults.standard.synchronize()
        }
        return keyFound
    }
}



