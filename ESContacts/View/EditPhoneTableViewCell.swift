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
    
    var id: String = ""
    var delegate: EditPhoneDelegate?
    
    func configureCell(_ info: PhoneNumber) {
        typeField.text = info.type
        numberField.text = info.value
        id = info.id
        
    }
    @IBAction func typeFieldEndEditing(_ sender: Any) {
        delegate?.updatePhoneType(id, type: typeField.text ?? "")
    }
    @IBAction func numberFieldEndEditing(_ sender: Any) {
        delegate?.updatePhoneNumber(id, number: numberField.text ?? "")
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        delegate?.deletePhone(id)
    }
    
}
