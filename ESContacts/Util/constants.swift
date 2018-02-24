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
    static var TableViewFont = UIFont(name: AppFontName, size: 14.0)
    static var TableViewDetailFont = UIFont(name: AppFontName, size: 12.0)
    static var TableViewBoldFont = UIFont(name: AppBoldFontName, size: 14.0)
    static var HeaderButtonFont = UIFont(name: AppFontName, size: 12.0)
    static var FooterButtonFont = UIFont(name: AppFontName, size: 14.0)
}

class Colors {
    static var sysBlue =  UIColor(red: 18.0/255.0, green: 149.0/255.0, blue: 1, alpha: 1)
    static var bottomBorder =  UIColor(red: 230/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 0.8)
     static var textField =  UIColor.darkText
}

let SAVE_NOTIFICATION = "ContactSaved"
let DELETE_NOTIFICATION = "ContactDelete"
