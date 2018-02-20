//
//  EditDetailsHeaderView.swift
//  ESContacts
//
//  Created by michael dunn on 2/20/18.
//  Copyright © 2018 michael dunn. All rights reserved.
//

import UIKit

protocol EditDetailsActionDelegate {
    func addNewRow(_ section: Int)
}

class EditDetailsHeaderView: UITableViewHeaderFooterView {

    private var section: Int = 0
    var delegate: EditDetailsActionDelegate?
    
    func configure(_ section: Int, title: String, centered: Bool) {
        self.section = section
        var btnFrame: CGRect
        if centered {
            btnFrame = frame
        }
        else {
           btnFrame = CGRect(x: frame.origin.x + frame.width - 100, y: frame.origin.y, width: 100, height: frame.height)
        }
        let button = UIButton(frame: btnFrame)
        button.titleLabel?.font = centered ? Fonts.FooterButtonFont : Fonts.HeaderButtonFont
        contentView.addSubview(button)
        
        button.setTitle(title, for: .normal)
        button.setTitleColor(Colors.sysBlue, for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
    }
    
    @objc func buttonTapped(sender: Any) {
        delegate?.addNewRow(section)
    }

}
