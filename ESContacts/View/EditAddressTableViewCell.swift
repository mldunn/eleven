//
//  EditAddressTableViewCell.swift
//  ESContacts
//
//  Created by michael dunn on 2/20/18.
//  Copyright © 2018 michael dunn. All rights reserved.
//

import UIKit

protocol EditAddressDelegate {
    func updateAddressField(_ id: String, field: Address.AddressField, value: String?)
    func deleteAddress(_ id: String)
}
class EditAddressTableViewCell: UITableViewCell {

    @IBOutlet weak var typeField: UITextField!
    @IBOutlet weak var zipField: UITextField!
    @IBOutlet weak var stateField: UITextField!
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var street2Field: UITextField!
    @IBOutlet weak var street1Field: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var id: String = ""
    var delegate: EditAddressDelegate?
    
    func configureCell(_ info: Address) {
        id = info.id
        typeField.text = info.type
        zipField.text = info.zip
        stateField.text = info.state
        cityField.text = info.city
        street2Field.text = info.street2
        street1Field.text = info.street1
    }
    
    
    @IBAction func stree1EndEditing(_ sender: Any) {
        delegate?.updateAddressField(id, field: .street1, value: street1Field.text)
    }
    @IBAction func street2EndEditing(_ sender: Any) {
        delegate?.updateAddressField(id, field: .street2, value: street2Field.text)
    }
    @IBAction func cityEndEditing(_ sender: Any) {
        delegate?.updateAddressField(id, field: .city, value: cityField.text)
    }
    @IBAction func stateEndEditing(_ sender: Any) {
        delegate?.updateAddressField(id, field: .state, value: stateField.text)
    }
    @IBAction func zipEndEditing(_ sender: Any) {
        delegate?.updateAddressField(id, field: .zip, value: zipField.text)
    }
    @IBAction func typeEndEditing(_ sender: Any) {
        delegate?.updateAddressField(id, field: .type, value: typeField.text)
    }
    @IBAction func buttonDeleteTapped(_ sender: Any) {
        delegate?.deleteAddress(id)
    }
}
