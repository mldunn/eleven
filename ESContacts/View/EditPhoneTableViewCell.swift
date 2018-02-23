//
//  EditPhoneTableViewCell.swift
//  ESContacts
//
//  Created by michael dunn on 2/20/18.
//  Copyright © 2018 michael dunn. All rights reserved.
//

import UIKit

protocol EditPhoneDelegate {
    func deletePhone(_ phone: PhoneData)
}

class EditPhoneTableViewCell: UITableViewCell {
    
    @IBOutlet weak var numberField: UITextField!
    @IBOutlet weak var typeField: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderWidth = 0
        layer.backgroundColor = UIColor.blue.cgColor
    }
    
    var delegate: EditPhoneDelegate?
    var phone: PhoneData!
    
    func configureCell(_ info: PhoneData) {
        typeField.text = info.type
        numberField.text = info.value
        phone = info
    }
   
    @IBAction func typeFieldChanged(_ sender: Any) {
        phone?.type = typeField.text
    }
    @IBAction func numberFieldChanged(_ sender: Any) {
        phone?.value = numberField.text
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        delegate?.deletePhone(phone)
    }
    
}
