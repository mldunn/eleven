//
//  EditPhoneTableViewCell.swift
//  ESContacts
//
//  Created by michael dunn on 2/20/18.
//  Copyright © 2018 michael dunn. All rights reserved.
//

import UIKit
import CoreData



class EditPhoneTableViewCell: UITableViewCell {
    @IBOutlet weak var typeButton: LabelPickerButton!
    
    @IBOutlet weak var numberField: ItemTextField!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var phone: PhoneData?
    var delegate: DetailTypeDelegate?
    override func prepareForReuse() {
        typeButton.setTitle("", for: .normal)
        numberField.text = ""
        phone = nil
    }
    
    func configureCell(_ info: PhoneData) {
        numberField.text = info.value
        typeButton.setTitle(info.type, for: .normal)
        phone = info
    }
   
    
    @IBAction func numberFieldChanged(_ sender: Any) {
        phone?.value = numberField.text
    }
    @IBAction func typeButtonTapped(_ sender: Any) {
        delegate?.changeLabel(phone)
    }
    
   
}
