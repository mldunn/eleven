//
//  PhoneTableViewCell.swift
//  ESContacts
//
//  Created by michael dunn on 2/19/18.
//  Copyright © 2018 michael dunn. All rights reserved.
//

import UIKit

class PhoneTableViewCell: UITableViewCell {

    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        valueLabel.textColor = Colors.customBlue
    }
    
    func configureCell(_ info: PhoneData) {
        typeLabel.text = info.type
        valueLabel.text = info.formatted
    }

}
