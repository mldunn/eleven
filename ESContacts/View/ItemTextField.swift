//
//  ItemTextField.swift
//  ESContacts
//
//  Created by michael dunn on 2/19/18.
//  Copyright © 2018 michael dunn. All rights reserved.
//

import UIKit

@IBDesignable
class ItemTextField: UITextField {
    
    let insetX: CGFloat = 12
    let insetY: CGFloat = 12
    
    @IBInspectable var leftBorder: Bool = false {
        didSet {
            if leftBorder {
                DispatchQueue.main.async {
                    self.createLeftBorder()
                }
            }
        }
    }
    
    @IBInspectable var bottomBorder: Bool = false {
        didSet {
            if bottomBorder {
                DispatchQueue.main.async {
                    self.createBottomBorder()
                }
            }
        }
    }

    func createLeftBorder() {
        let border = CALayer()
        border.backgroundColor = UIColor.lightGray.cgColor
        border.frame = CGRect(x: 0, y: 0, width: 0.5, height: frame.height)
        layer.addSublayer(border)

    }
    
    
    func createBottomBorder() {
        
        let y = frame.height
        let border = CALayer()
        border.backgroundColor = UIColor.lightGray.cgColor
        border.frame = CGRect(x: 0, y: y, width: frame.width, height: 0.5)
        layer.addSublayer(border)

    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        textColor = Colors.textField
        font = Fonts.itemTextField
        borderStyle = .none
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        if bottomBorder {
            createBottomBorder()
        }
    }
   
  
    
    // placeholder position
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let inset = super.textRect(forBounds: bounds)
        return inset.insetBy(dx: insetX, dy: 0)
    }
    
    // text position
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let inset = super.textRect(forBounds: bounds)
        return inset.insetBy(dx: insetX, dy: 0)
    }

}
