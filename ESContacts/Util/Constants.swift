//
//  constants.swift
//  ESContacts
//
//  Created by michael dunn on 2/19/18.
//  Copyright © 2018 michael dunn. All rights reserved.
//

import Foundation
import UIKit

//
// global contants for fonts and colors
//

class Fonts {
    static var AppFontName = "HelveticaNeue"
    static var itemTextField = UIFont(name: AppFontName, size: 14.0)
    static var tableViewFooter = UIFont(name: AppFontName, size: 16.0)
    static var tableViewDetail = UIFont(name: AppFontName, size: 12.0)
    static var tableViewItemBold = UIFont(name: AppFontName+"-Bold", size: 16.0)
    static var tableViewItem = UIFont(name: AppFontName, size: 16.0)
}

class Colors {
    static var customBlue = UIColor(red: 87.0/255.0, green: 130.0/255.0, blue: 180.0/255.0, alpha: 1)
    static var sysBlue = UIColor(red: 18.0/255.0, green: 149.0/255.0, blue: 255.0/255.0, alpha: 1)
    static var navBar = UIColor(red: 249.0/255.0, green: 249.0/255.0, blue: 249.0/255.0, alpha: 1.0)
    static var tableHeader = UIColor(red: 242.0/255.0, green: 242.0/255.0, blue: 242.0/255.0, alpha: 1.0)
    static var textField =  UIColor.darkText
}

//
// simple array of letters for the index on the table view
//

let letterHeaders = [ "A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","#"]

let SAVE_NOTIFICATION = "ContactSaved"
let DELETE_NOTIFICATION = "ContactDelete"
