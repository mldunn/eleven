//
//  EditDetailsViewController.swift
//  ESContacts
//
//  Created by michael dunn on 2/19/18.
//  Copyright © 2018 michael dunn. All rights reserved.
//

import UIKit
import CoreData

class EditDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, EditPhoneDelegate, EditAddressDelegate, EditDetailsActionDelegate {
    
    
    enum DismissAction {
        case save
        case cancel
        case delete
    }

    enum AddDetailRowType: Int {
        case none = -1
        case phone = 0
        case address = 1
        case email = 2
        case delete = 3
    }
    
    @IBOutlet weak var companyField: ItemTextField!
    @IBOutlet weak var lastNameField: ItemTextField!
    @IBOutlet weak var firstNameField: ItemTextField!
    
    @IBOutlet weak var detailsTableView: UITableView!
    
    var existingContact: ContactData?
    var newContact: ContactData!
    
    var managedContext: NSManagedObjectContext?
    var sectionHeaders = ["add phone", "add address", "Delete Contact"]
    
    var isExistingContact: Bool {
        get {
            return existingContact != nil
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let c = existingContact {
            newContact = c
            bindFields()
        }
        else {
            title = "New Contact"
            newContact = ContactData()
        }
        checkFields()
        
        detailsTableView.dataSource = self
        detailsTableView.delegate = self
        detailsTableView.tableFooterView = UIView()
        detailsTableView.setEditing(true, animated: false)
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
    
    func dismissVC(_ action: DismissAction) {
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            
            let managedContext = appDelegate.persistentContainer.viewContext
            
            do {
                if action == .cancel {
                    managedContext.rollback()
                }
                else {
                    var notification: String!
                    if action == .save {
                        saveFields()
                        notification = SAVE_NOTIFICATION
                    }
                    else if action == .delete {
                        if let c = existingContact {
                            managedContext.delete(c)
                        }
                        notification = DELETE_NOTIFICATION
                    }
                    
                    try managedContext.save()
                    
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: notification), object: self)
                }
                dismiss(animated: true, completion: nil)
                
            }
            catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        
        dismissVC(.save)
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismissVC(.cancel)
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
    
    func getPhoneInfo(_ index: Int) -> PhoneData? {
        return newContact.getPhoneByIndex(index)
    }
    
    func getAddressInfo(_ index: Int) -> AddressData? {
        return newContact.getAddressByIndex(index)
    }
    
    func addNewRow(_ section: Int) {
        if section == 2 {
            // delete
            dismissVC(.delete)
            return
        }
        else {
            let rowIndex = detailsTableView.numberOfRows(inSection: section)
            let indexPath = IndexPath(row: rowIndex, section: section)
            if section == 0 {
                newContact.addPhone()
            }
            else if section == 1 {
                newContact.addAddress()
            }
            detailsTableView.insertRows(at: [indexPath], with: .bottom)
            detailsTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
}

extension EditDetailsViewController {
 
    func updateAddressField(_ id: String, field: Address.AddressField, value: String?) {
        //xx  newContact.updateAddressField(id, field: field, value: value ?? "")
    }
    
    func deleteAddress(_ id: String) {
        //xx  newContact.removeAddress(id)
        detailsTableView.reloadData()
    }
    
    func deletePhone(_ phone: PhoneData) {
        //xx   newContact.removePhone(id)
        detailsTableView.reloadData()
    }
    
}


extension EditDetailsViewController {
    
    func isAddDetailsRow(indexPath: IndexPath) -> Bool {
    
        if indexPath.row == (detailsTableView.numberOfRows(inSection: indexPath.section) - 1) {
            return true
        }
        else {
            return false
        }
    }
    
    @objc func addDetail(_ sender: Any) {
        if let btn = sender as? UIButton {
            print(btn.tag)
        }
    }
    
    @available(iOS 11.0, *)
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        return nil
    }
    
    @available(iOS 11.0, *)
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, handler) in
            //YOUR_CODE_HERE
        }
        deleteAction.backgroundColor = .red
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            // delete item at indexPath
        }
        
        let share = UITableViewRowAction(style: .normal, title: "Disable") { (action, indexPath) in
            // share item at indexPath
        }
        
        share.backgroundColor = UIColor.blue
        
        return [delete, share]
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
    
        if isAddDetailsRow(indexPath: indexPath) {
            return UITableViewCellEditingStyle.insert
        }
        else {
            return UITableViewCellEditingStyle.delete
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        // ignore last row
        
        if (isExistingContact && (indexPath.section == tableView.numberOfSections - 1)) {
            return false
        }
        return true
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = EditDetailsHeaderView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 40))
        headerView.configure(section, title: sectionHeaders[section], centered: section == 2)
        headerView.delegate = self
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let frame = tableView.frame
        
        let button = UIButton(frame: CGRect(x: 5, y: 10, width: 15, height: 15))  // create button
        button.tag = section
        // the button is image - set image
      //  button.setImage(UIImage(named: "remove_button"), forState: .normal)  // assumes there is an image named "remove_button"
        button.addTarget(self, action: #selector(EditDetailsViewController.addDetail(_:)), for: .touchUpInside)
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        
        headerView.addSubview(button)   // add the button to the view
        
        return headerView
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        var count = 2
        
        // add one for "Delete Contact"
        if isExistingContact {
            count += 1
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        if section == 0 {
            if let items = newContact.phoneItems {
                count = items.count
            }
        }
        else if section == 1 {
            if let items = newContact.addressItems {
                count = items.count
            }
        }
        // add one to include the add row
        return count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if isAddDetailsRow(indexPath: indexPath) {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "addDetailCell") {
                cell.textLabel?.text = sectionHeaders[indexPath.section]
                return cell
            }
        }
        else if indexPath.section == 0 {
            
            if let info = getPhoneInfo(indexPath.row), let cell = tableView.dequeueReusableCell(withIdentifier: "editPhoneCell") as? EditPhoneTableViewCell {
                cell.delegate = self
                cell.selectionStyle = .none
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

