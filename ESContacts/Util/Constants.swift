//
//  constants.swift
//  ESContacts
//
//  Created by michael dunn on 2/19/18.
//  Copyright © 2018 michael dunn. All rights reserved.
//

import Foundation
import UIKit

class Fonts {
    static var AppFontName = "HelveticaNeue"
    static var AppBoldFontName = AppFontName + "-Bold"
    static var AppLightFontName = AppFontName + "-Light"
    static var itemTextField = UIFont(name: AppFontName, size: 14.0)
    static var tableViewFooter = UIFont(name: AppFontName, size: 16.0)
    static var tableViewDetail = UIFont(name: AppFontName, size: 12.0)
    static var tableViewBold = UIFont(name: AppBoldFontName, size: 14.0)
}

class Colors {
    static var customBlue = UIColor(red: 87.0/255.0, green: 130.0/255.0, blue: 180.0/255.0, alpha: 1)
    static var sysBlue = UIColor(red: 18.0/255.0, green: 149.0/255.0, blue: 255.0/255.0, alpha: 1)
    static var navBar = UIColor(red: 249.0/255.0, green: 249.0/255.0, blue: 249.0/255.0, alpha: 1.0)
    static var tableHeader = UIColor(red: 242.0/255.0, green: 242.0/255.0, blue: 242.0/255.0, alpha: 1.0)
    static var circlebottom = UIColor(red: 138.0/255.0, green: 142.0/255.0, blue: 151.0/255.0, alpha: 1.0)
    static var circletop = UIColor(red: 166.0/255.0, green: 171.0/255.0, blue: 183.0/255.0, alpha: 1.0)
    static var textField =  UIColor.darkText
}


let letterHeaders = [ "A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","#"]

let SAVE_NOTIFICATION = "ContactSaved"
let DELETE_NOTIFICATION = "ContactDelete"
