//
//  DetailsViewController.swift
//  ESContacts
//
//  Created by michael dunn on 2/19/18.
//  Copyright © 2018 michael dunn. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var contact: ContactData?
   
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
        
        // listen for contact changed
        NotificationCenter.default.addObserver(self, selector: #selector(handleChange), name: Notification.Name(rawValue: SAVE_NOTIFICATION), object: nil)

    }
    
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editContact" {
            if let nav = segue.destination as? UINavigationController {
                if let vc = nav.viewControllers.first as? EditDetailsViewController {
                    vc.existingContact = contact
                }
            }
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
        editContact()
    }
    
    func editContact() {
        performSegue(withIdentifier: "editContact", sender: contact)
    }
    
    @objc func handleChange(_ sender: Any) {
        
        if let id = contact?.id {
            contact = ContactHelper.getContact(id)
        }
        DispatchQueue.main.async {
            
          
            self.bindFields()
        }
    }
    
    func bindFields() {
        
        if let c = contact {
            initialLabel.text = c.initials
            displayName.text = c.displayName
            companyLabel.text = c.company
            detailsTableView.reloadData()
        }
    }
    
    func getPhoneInfo(_ index: Int) -> PhoneData? {
        return contact?.getPhoneByIndex(index)
    }
    
    func getAddressInfo(_ index: Int) -> AddressData? {
        return contact?.getAddressByIndex(index)
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
                count = c.phoneItems?.count ?? 0
            }
            else if section == 1 {
                count = c.addressItems?.count ?? 0
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
