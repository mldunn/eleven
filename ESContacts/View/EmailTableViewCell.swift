//
//  EmailTableViewCell.swift
//  ESContacts
//
//  Created by michael dunn on 2/24/18.
//  Copyright © 2018 michael dunn. All rights reserved.
//

import UIKit

class EmailTableViewCell: UITableViewCell {

    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        valueLabel.textColor = Colors.customBlue
    }
    
    func configureCell(_ info: EmailData) {
        typeLabel.text = info.type
        valueLabel.text = info.value
    }
}
