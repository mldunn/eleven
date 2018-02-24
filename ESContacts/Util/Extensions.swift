//
//  Extensions.swift
//  ESContacts
//
//  Created by michael dunn on 2/24/18.
//  Copyright © 2018 michael dunn. All rights reserved.
//

import Foundation
import UIKit


extension UILabel {
    
    
    func highlightAtIndex(index: Int, bold: Bool, color: UIColor?) {
        if let caption = text {
            let maText = NSMutableAttributedString(string: caption)
            var attrs: [NSAttributedStringKey: Any] = [:]
            if bold {
                attrs[NSAttributedStringKey.font] = UIFont.boldSystemFont(ofSize: font.pointSize)
            }
            if let clr = color {
                attrs[NSAttributedStringKey.foregroundColor] = clr
            }
            let range = NSRange.init(location: index, length: caption.count - index)
            
            maText.addAttributes(attrs, range: range)
            attributedText = maText
        }
    }
    
}
extension String {
    
    func isAlpha() -> Bool {
        return self.rangeOfCharacter(from: CharacterSet.letters.inverted) == nil && self != ""
    }
}



