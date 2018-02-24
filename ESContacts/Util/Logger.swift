//
//  Logger.swift
//  ESContacts
//
//  Created by michael dunn on 2/24/18.
//  Copyright © 2018 michael dunn. All rights reserved.
//

import Foundation

class Logger {
    
    static func log(_ msg: String) {
        print("LOG: \(msg)")
    }
    
    static func error(_ error: NSError, message: String?) {
        if let msg = message {
            print("ERROR: \(msg) \(error), \(error.userInfo)")
        }
        else {
            print("ERROR: \(error), \(error.userInfo)")
        }
    }
}
