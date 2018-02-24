//
//  VerticalSeparaterView.swift
//  ESContacts
//
//  Created by michael dunn on 2/24/18.
//  Copyright © 2018 michael dunn. All rights reserved.
//

import UIKit

class VerticalSeparaterView: UIView {

    func createLine() {
        let border = CALayer()
        border.backgroundColor = UIColor.lightGray.cgColor
        border.frame = CGRect(x: frame.width - 1, y: 0, width: 0.5, height: frame.height)
        layer.addSublayer(border)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createLine()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createLine()
    }
}
