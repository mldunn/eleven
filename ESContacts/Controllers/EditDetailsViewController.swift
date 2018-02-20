//
//  EditDetailsViewController.swift
//  ESContacts
//
//  Created by michael dunn on 2/19/18.
//  Copyright © 2018 michael dunn. All rights reserved.
//

import UIKit

class EditDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, EditPhoneDelegate, EditAddressDelegate, EditDetailsActionDelegate {
    
    @IBOutlet weak var companyField: ItemTextField!
    @IBOutlet weak var lastNameField: ItemTextField!
    @IBOutlet weak var firstNameField: ItemTextField!
    
    @IBOutlet weak var detailsTableView: UITableView!
    
    var existingContact: Contact?
    var newContact = Contact()
    var delegate: ManageContactDelegate?
    
    var sectionHeaders = ["Add Phone", "Add Address", "Delete Contact"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailsTableView.dataSource = self
        detailsTableView.delegate = self
        detailsTableView.tableFooterView = UIView()
        
        if let c = existingContact {
            newContact = Contact(clone: c)
            bindFields()
        }
        else {
            title = "New Contact"
        }
        checkFields()
    }
    
    func checkFields() {
        let enableDone = (firstNameField.text?.count ?? 0) + (lastNameField.text?.count ?? 0)
            + (companyField.text?.count ?? 0)
        
        doneButton.isEnabled = enableDone > 0
    }
    
    
    func bindFields() {
        firstNameField.text = newContact.firstName
        lastNameField.text = newContact.lastName
        companyField.text = newContact.company
    }
    
    func saveFields() {
        newContact.firstName = firstNameField.text
        newContact.lastName = lastNameField.text
        newContact.company = companyField.text
    }
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBAction func doneButtonTapped(_ sender: Any) {
        saveFields()
      
        dismiss(animated: true, completion: {
          self.delegate?.contactChanged(self.newContact)
        })
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func firstNameChanged(_ sender: Any) {
        if let field = sender as? ItemTextField {
            newContact.firstName = field.text
            checkFields()
        }
    }
    
    @IBAction func lastNameChanged(_ sender: Any) {
        if let field = sender as? ItemTextField {
            newContact.lastName = field.text
            checkFields()
        }
    }
    
    @IBAction func companyChanged(_ sender: Any) {
        if let field = sender as? ItemTextField {
            newContact.company = field.text
            checkFields()
        }
    }
    
    func getPhoneInfo(_ index: Int) -> PhoneNumber? {
        return newContact.getPhoneByIndex(index)
    }
    
    func getAddressInfo(_ index: Int) -> Address? {
        return newContact.getAddressByIndex(index)
    }
    
    
    func addNewRow(_ section: Int) {
        var indexPath: IndexPath?
        if section == 2 {
            // delete
            if let c = existingContact {
                delegate?.contactDeleted(c)
            }
            dismiss(animated: true, completion: nil)
            return
        }
        else if section == 0 {
            let phone = PhoneNumber()
            newContact.addPhone(phone)
           indexPath = IndexPath(row: newContact.phoneCount - 1, section: section)
        }
        else if section == 1 {
            let address = Address()
            newContact.addAddress(address)
            indexPath = IndexPath(row: newContact.addressCount - 1, section: section)
        }
        if let ip = indexPath {
            detailsTableView.insertRows(at: [ip], with: .bottom)
            detailsTableView.scrollToRow(at: ip, at: .bottom, animated: true)
        }
    }
}

extension EditDetailsViewController {
    func updatePhoneNumber(_ id: String, number: String) {
        newContact.updatePhoneNumber(id, number: number)
    }
    
    func updatePhoneType(_ id: String, type: String) {
        newContact.updatePhoneType(id, type: type)
    }
    
    func updateAddressField(_ id: String, field: Address.AddressField, value: String?) {
        newContact.updateAddressField(id, field: field, value: value ?? "")
    }
    
    func deleteAddress(_ id: String) {
        newContact.removeAddress(id)
        detailsTableView.reloadData()
    }
    
    func deletePhone(_ id: String) {
        newContact.removePhone(id)
        detailsTableView.reloadData()
    }
}


extension EditDetailsViewController {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = EditDetailsHeaderView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 40))
        
        headerView.configure(section, title: sectionHeaders[section], centered: section == 2)
        headerView.delegate = self
        return headerView
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        var count = 2
        if let _ = existingContact {
            count += 1
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var count = 0
        if section == 0 {
            count = newContact.phoneCount
        }
        else if section == 1 {
            count = newContact.addressCount
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if let info = getPhoneInfo(indexPath.row), let cell = tableView.dequeueReusableCell(withIdentifier: "editPhoneCell") as? EditPhoneTableViewCell {
                cell.delegate = self
                cell.configureCell(info)
                return cell
            }
        }
        else if indexPath.section == 1 {
            if let info = getAddressInfo(indexPath.row), let cell = tableView.dequeueReusableCell(withIdentifier: "editAddressCell") as? EditAddressTableViewCell {
                cell.delegate = self
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
            return 200
        }
        else {
            return tableView.rowHeight
        }
    }
    
}

