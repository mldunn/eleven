//
//  BorderlessTextField.swift
//  ESContacts
//
//  Created by michael dunn on 2/24/18.
//  Copyright © 2018 michael dunn. All rights reserved.
//

import UIKit

class BorderlessTextField: UITextField {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        textColor = Colors.textField
        font = Fonts.itemTextField
        borderStyle = .none
        
    }

}
