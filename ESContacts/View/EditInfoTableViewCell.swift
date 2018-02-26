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
    
    @IBOutlet weak var cardImageView: UIImageView!
    var contact: ContactData?
    var delegate: ContactUpdateDelegate?
  

    func configureCell(_ info: ContactData) {
        firstNameField.text = info.firstName
        lastNameField.text = info.lastName
        companyField.text = info.company
        contact = info
        if contact?.isValid == false {
            firstNameField.becomeFirstResponder()
        }
        
        cardImageView.image = cardImageView.image?.withRenderingMode(.alwaysTemplate)
        cardImageView.tintColor = Colors.customBlue
        
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
