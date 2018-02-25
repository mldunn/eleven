//
//  EditPhoneTableViewCell.swift
//  ESContacts
//
//  Created by michael dunn on 2/20/18.
//  Copyright © 2018 michael dunn. All rights reserved.
//

import UIKit


class EditPhoneTableViewCell: UITableViewCell {
    
    @IBOutlet weak var numberField: ItemTextField!
    @IBOutlet weak var typeField: ItemTextField!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var phone: PhoneData?
    
    override func prepareForReuse() {
        typeField.text = ""
        numberField.text = ""
        phone = nil
    }
    
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
    
   
}
