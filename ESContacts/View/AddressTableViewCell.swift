//
//  AddressTableViewCell.swift
//  ESContacts
//
//  Created by michael dunn on 2/19/18.
//  Copyright © 2018 michael dunn. All rights reserved.
//

import UIKit

class AddressTableViewCell: UITableViewCell {

    @IBOutlet weak var blurbLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    func configureCell(_ info: AddressData) {
        typeLabel.text = info.type
        blurbLabel.text = info.blurb
    }

}
