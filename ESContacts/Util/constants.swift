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
    static var TableViewFont = UIFont(name: AppFontName, size: 14.0)
    static var TableViewBoldFont = UIFont(name: AppBoldFontName, size: 14.0)
    static var HeaderButtonFont = UIFont(name: AppFontName, size: 12.0)
    static var FooterButtonFont = UIFont(name: AppFontName, size: 14.0)
}

class Colors {
    static var sysBlue =  UIColor(red: 18.0/255.0, green: 149.0/255.0, blue: 1, alpha: 1)
}


extension UILabel {
    
    func highlightTerm(term: String, bold: Bool, color: UIColor?) {
        
        if let caption = text {
            let maText = NSMutableAttributedString(string: caption)
            var attrs: [NSAttributedStringKey: Any] = [:]
            if bold {
                attrs[NSAttributedStringKey.font] = UIFont.boldSystemFont(ofSize: font.pointSize)
            }
            if let clr = color {
                attrs[NSAttributedStringKey.foregroundColor] = clr
            }
            let range = NSString(string: caption).range(of: term)
            maText.addAttributes(attrs, range: range)
            attributedText = maText
        }
    }
}



