//
//  BaseViewController.swift
//  ESContacts
//
//  Created by michael dunn on 2/25/18.
//  Copyright © 2018 michael dunn. All rights reserved.
//

import UIKit


//
// a common base class to handle common tasks for every view controller
// right now we are just setting our custom font and color
// worthwhile in other cases for sending metrics or other tasks
//

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if let navigationBar = navigationController?.navigationBar {
            
            navigationBar.tintColor = Colors.customBlue
            navigationBar.barTintColor = Colors.navBar
            
        }
    }

}
