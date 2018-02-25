//
//  EditAddressTableViewCell.swift
//  ESContacts
//
//  Created by michael dunn on 2/20/18.
//  Copyright © 2018 michael dunn. All rights reserved.
//

import UIKit


class EditAddressTableViewCell: UITableViewCell {

    @IBOutlet weak var typeButton: LabelPickerButton!
    @IBOutlet weak var street1Field: ItemTextField!
    @IBOutlet weak var street2Field: ItemTextField!
    @IBOutlet weak var cityField: ItemTextField!
    @IBOutlet weak var stateField: ItemTextField!
    @IBOutlet weak var zipField: ItemTextField!
    @IBOutlet weak var countryField: ItemTextField!
        
    var address: AddressData?
    var delegate: DetailTypeDelegate?
    
    func configureCell(_ info: AddressData) {
        typeButton.setTitle(info.type, for: .normal)
        zipField.text = info.zipcode
        stateField.text = info.state
        cityField.text = info.city
        street2Field.text = info.street2
        street1Field.text = info.street1
        countryField.text = info.country
        address = info
    }
    
    override func becomeFirstResponder() -> Bool {
        return street1Field.becomeFirstResponder()
    }
   
    @IBAction func street1Changed(_ sender: Any) {
        address?.street1 = street1Field.text
    }
    
    @IBAction func street2Changed(_ sender: Any) {
        address?.street2 = street2Field.text
    }
    
    @IBAction func cityChanged(_ sender: Any) {
        address?.city = cityField.text
    }
    
    @IBAction func countryChanged(_ sender: Any) {
        address?.country = countryField.text
    }
    
    @IBAction func stateChanged(_ sender: Any) {
        address?.state = stateField.text
    }
    
    @IBAction func zipChanged(_ sender: Any) {
        address?.zipcode = zipField.text
    }
    
    @IBAction func typeButtonTapped(_ sender: Any) {
         delegate?.changeLabel(address)
    }
}
