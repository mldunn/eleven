//
//  EditAddressTableViewCell.swift
//  ESContacts
//
//  Created by michael dunn on 2/20/18.
//  Copyright © 2018 michael dunn. All rights reserved.
//

import UIKit


class EditAddressTableViewCell: UITableViewCell {

    
    @IBOutlet weak var street1Field: ItemTextField!
    @IBOutlet weak var street2Field: ItemTextField!
    @IBOutlet weak var cityField: ItemTextField!
    @IBOutlet weak var stateField: ItemTextField!
    @IBOutlet weak var zipField: BorderlessTextField!
    @IBOutlet weak var typeField: ItemTextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var address: AddressData?
    
    func configureCell(_ info: AddressData) {
        typeField.text = info.type
        zipField.text = info.zipcode
        stateField.text = info.state
        cityField.text = info.city
        street2Field.text = info.street2
        street1Field.text = info.street1
        address = info
    }
    
    
    @IBAction func stree1EndEditing(_ sender: Any) {
        address?.street1 = street1Field.text
    }
    @IBAction func street2EndEditing(_ sender: Any) {
       address?.street2 =  street2Field.text
    }
    @IBAction func cityEndEditing(_ sender: Any) {
        address?.city = cityField.text
    }
    @IBAction func stateEndEditing(_ sender: Any) {
        address?.state = stateField.text
    }
    @IBAction func zipEndEditing(_ sender: Any) {
        address?.zipcode = zipField.text
    }
    @IBAction func typeEndEditing(_ sender: Any) {
        address?.type = typeField.text
    }
    
}
