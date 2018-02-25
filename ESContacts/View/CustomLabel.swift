//
//  CustomLabel.swift
//  ESContacts
//
//  Created by michael dunn on 2/25/18.
//  Copyright © 2018 michael dunn. All rights reserved.
//

import UIKit

class CustomLabel: UILabel {

    override func awakeFromNib() {
        
        // set the font for our custom label
        var suffix = ""
        if let index = font.fontName.index(of: "-") {
            suffix = String(font.fontName.suffix(from: index))
        }
        font = UIFont(name: Fonts.AppFontName + suffix, size: font.pointSize)
    }
}
