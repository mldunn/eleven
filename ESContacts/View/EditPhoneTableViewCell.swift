//
//  EditPhoneTableViewCell.swift
//  ESContacts
//
//  Created by michael dunn on 2/20/18.
//  Copyright © 2018 michael dunn. All rights reserved.
//

import UIKit

protocol EditPhoneDelegate {
    func updatePhoneType(_ id: String, type: String)
    func updatePhoneNumber(_ id: String, number: String)
    func deletePhone(_ id: String)
}

class EditPhoneTableViewCell: UITableViewCell {
    
    @IBOutlet weak var numberField: UITextField!
    @IBOutlet weak var typeField: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var delegate: EditPhoneDelegate?
    var phone: PhoneData?
    func configureCell(_ info: PhoneData) {
        typeField.text = info.type
        numberField.text = info.value
        phone = info
    }
    @IBAction func typeFieldEndEditing(_ sender: Any) {
       phone?.type = typeField.text
    }
    @IBAction func numberFieldEndEditing(_ sender: Any) {
        phone?.value = numberField.text
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
     //xxx   delegate?.deletePhone(phone)
    }
    
}
