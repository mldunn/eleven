//
//  EditInfoTableViewCell.swift
//  ESContacts
//
//  Created by michael dunn on 2/23/18.
//  Copyright © 2018 michael dunn. All rights reserved.
//

import UIKit

protocol ContactUpdateDelegate {
    func infoChanged()
}


class EditInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var lastNameField: ItemTextField!
    @IBOutlet weak var companyField: ItemTextField!
    @IBOutlet weak var firstNameField: ItemTextField!
    
    var contact: ContactData?
    var delegate: ContactUpdateDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(_ info: ContactData) {
        firstNameField.text = info.firstName
        lastNameField.text = info.lastName
        companyField.text = info.company
        contact = info
        if contact?.isValid == false {
            firstNameField.becomeFirstResponder()
        }
    }
    
    @IBAction func firstNameChanged(_ sender: Any) {
        contact?.firstName = firstNameField.text
        delegate?.infoChanged()
    }
    
    @IBAction func lastNameChanged(_ sender: Any) {
        contact?.lastName = lastNameField.text
        delegate?.infoChanged()
    }
    
    @IBAction func companyChanged(_ sender: Any) {
        contact?.company = companyField.text
        delegate?.infoChanged()
    }
    
    

}
