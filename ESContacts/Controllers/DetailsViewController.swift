//
//  DetailsViewController.swift
//  ESContacts
//
//  Created by michael dunn on 2/19/18.
//  Copyright © 2018 michael dunn. All rights reserved.
//

import UIKit



class DetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ManageContactDelegate {
    
    var contact: Contact?
    var delegate: ManageContactDelegate?
    @IBOutlet weak var detailsTableView: UITableView!
    
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var displayName: UILabel!
    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var initialLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        circleView.layer.cornerRadius = circleView.bounds.width / 2
        
        detailsTableView.delegate = self
        detailsTableView.dataSource = self
        
        detailsTableView.tableFooterView = UIView()
        
        bindFields()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editContact" {
            if let nav = segue.destination as? UINavigationController {
                if let vc = nav.viewControllers.first as? EditDetailsViewController {
                    vc.delegate = self
                    vc.existingContact = contact
                }
            }
        }
    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
        editContact()
    }
    
    func editContact() {
        performSegue(withIdentifier: "editContact", sender: contact)
    }
    
    func bindFields() {
        if let c = contact {
            initialLabel.text = c.initials
            displayName.text = c.displayName
            companyLabel.text = c.company
            detailsTableView.reloadData()
        }
    }
    
    func getPhoneInfo(_ index: Int) -> PhoneNumber? {
        return contact?.getPhoneByIndex(index)
    }
    
    func getAddressInfo(_ index: Int) -> Address? {
        return contact?.getAddressByIndex(index)
    }
    
    
    func contactChanged(_ contact: Contact) {
        self.contact = contact
        bindFields()
        delegate?.contactChanged(contact)
    }
    
    func contactDeleted(_ contact: Contact) {
        delegate?.contactDeleted(contact)
    }
    
    
    
    
}

extension DetailsViewController {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var count = 0
        if let c = contact {
            if section == 0 {
                count = c.phoneCount
            }
            else if section == 1 {
                count = c.addressCount
            }
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if let info = getPhoneInfo(indexPath.row), let cell = tableView.dequeueReusableCell(withIdentifier: "phoneCell") as? PhoneTableViewCell {
                cell.configureCell(info)
                return cell
            }
        }
        else if indexPath.section == 1 {
            if let info = getAddressInfo(indexPath.row), let cell = tableView.dequeueReusableCell(withIdentifier: "addressCell") as? AddressTableViewCell {
                cell.configureCell(info)
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 60
        }
        else if indexPath.section == 1 {
            return 120
        }
        else {
            return tableView.rowHeight
        }
    }
}
