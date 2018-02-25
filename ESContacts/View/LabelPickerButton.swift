//
//  LabelPickerButton.swift
//  ESContacts
//
//  Created by michael dunn on 2/25/18.
//  Copyright © 2018 michael dunn. All rights reserved.
//

import UIKit

class LabelPickerButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
        titleLabel?.font = Fonts.tableViewDetail
    
        setTitleColor(Colors.customBlue, for: .normal)
    }
    
  
}
