//
//  EditEmailTableViewCell.swift
//  ESContacts
//
//  Created by michael dunn on 2/24/18.
//  Copyright © 2018 michael dunn. All rights reserved.
//

import UIKit

class EditEmailTableViewCell: UITableViewCell {

    @IBOutlet weak var valueField: ItemTextField!
    @IBOutlet weak var typeButton: LabelPickerButton!
    
    var email: EmailData?
    var delegate: DetailTypeDelegate?
    
    override func prepareForReuse() {
        typeButton.setTitle("", for: .normal)
        
        valueField.text = ""
        email = nil
    }
    
    func configureCell(_ info: EmailData) {
        typeButton.setTitle(info.type, for: .normal)
        valueField.text = info.value
        email = info
    }
   
    @IBAction func typeButtonTapped(_ sender: Any) {
        delegate?.changeLabel(email)
    }
    
    @IBAction func valueFieldChanged(_ sender: Any) {
        email?.value = valueField.text
    }
}
