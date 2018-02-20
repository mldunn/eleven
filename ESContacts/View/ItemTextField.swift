//
//  ItemTextField.swift
//  ESContacts
//
//  Created by michael dunn on 2/19/18.
//  Copyright © 2018 michael dunn. All rights reserved.
//

import UIKit

class ItemTextField: UITextField {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.textColor = UIColor.darkText

       clearButtonMode = UITextFieldViewMode.whileEditing
        
    }

}
