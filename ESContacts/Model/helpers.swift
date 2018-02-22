//
//  helpers.swift
//  ESContacts
//
//  Created by michael dunn on 2/21/18.
//  Copyright © 2018 michael dunn. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObject {
    
    class func entityName() -> String {
        return String(describing: self)
    }
    
    convenience init(context: NSManagedObjectContext) {
        let eName = type(of: self).entityName()
        let entity = NSEntityDescription.entity(forEntityName: eName, in: context)!
        self.init(entity: entity, insertInto: context)
    }
}


