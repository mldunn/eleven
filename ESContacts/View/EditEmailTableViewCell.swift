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
    @IBOutlet weak var typeField: ItemTextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var email: EmailData?
    
    override func prepareForReuse() {
        typeField.text = ""
        valueField.text = ""
        email = nil
    }
    
    func configureCell(_ info: EmailData) {
        typeField.text = info.type
        valueField.text = info.value
        email = info
    }
   
    @IBAction func typeFieldChanged(_ sender: Any) {
        email?.type = typeField.text
    }
    
    @IBAction func valueFieldChanged(_ sender: Any) {
        email?.value = valueField.text
    }
    
   

}
