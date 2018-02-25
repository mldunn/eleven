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
       
        //
        // set font and offset
        //
        titleLabel?.font = Fonts.tableViewDetail
        titleLabel?.textAlignment = .left
        contentHorizontalAlignment = .left
        contentEdgeInsets.left = 8.0
        setTitleColor(Colors.customBlue, for: .normal)
    }
    
}
