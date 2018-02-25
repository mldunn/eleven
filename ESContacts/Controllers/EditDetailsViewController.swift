        //
        //  EditDetailsViewController.swift
        //  ESContacts
        //
        //  Created by michael dunn on 2/19/18.
        //  Copyright © 2018 michael dunn. All rights reserved.
        //
        
        import UIKit
        import CoreData
        
        protocol DetailTypeDelegate {
            func changeLabel(_ item: NSManagedObject?)
        }
        
        class EditDetailsViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, DetailTypeDelegate, ContactUpdateDelegate   {
            
            
            enum DismissAction {
                case save
                case cancel
                case delete
            }
            
            @IBOutlet weak var detailsTableView: UITableView!
            @IBOutlet weak var doneButton: UIBarButtonItem!
            
            var existingContact: ContactData?
            var newContact: ContactData!
            var changeLabelSection: String = ""
            
            var managedContext: NSManagedObjectContext?
            
            var rowHeights: [CGFloat] = [134, 44, 44, 200, 44]
            
            var isExistingContact: Bool {
                get {
                    return existingContact != nil
                }
            }
            
            override func viewDidLoad() {
                super.viewDidLoad()
                
                if let c = existingContact {
                    newContact = c
                }
                else {
                    title = "New Contact"
                    newContact = ContactData()
                    detailsTableView.becomeFirstResponder()
                }
                
                navigationController?.navigationBar.backgroundColor = Colors.navBar
                
                infoChanged()
                
                detailsTableView.dataSource = self
                detailsTableView.delegate = self
                detailsTableView.tableFooterView = UIView()
                detailsTableView.setEditing(true, animated: false)
            }
            
            override func viewDidAppear(_ animated: Bool) {
                if let section = TypeLabels.sections.index(of: changeLabelSection)  {
                    changeLabelSection = ""
                    DispatchQueue.main.async {
                        self.detailsTableView.reloadSections([section], with: .none)
                    }
                }
            }
            
            override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                if segue.identifier == "changeLabel" {
                    if let nav = segue.destination as? UINavigationController {
                        if let vc = nav.viewControllers.first as? TypeLabelsTableViewController {
                            vc.type = changeLabelSection
                            vc.data = sender
                        }
                    }
                }
            }
           
            func infoChanged() {
                doneButton.isEnabled = newContact.isValid
            }
            
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
                                newContact.sanitize()
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
                        Logger.error(error, message: "save contact")
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
            
            @objc func deleteContact() {
                
                let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                let deleteAction = UIAlertAction(title: "Delete Contact",
                                                 style: .destructive,
                                                 handler: { _ in
                                                    self.dismissVC(.delete)
                })
                
                let cancelAction = UIAlertAction(title: "Cancel",
                                                 style: .cancel,
                                                 handler: nil)
                alert.addAction(deleteAction)
                alert.addAction(cancelAction)
                present(alert, animated: true, completion: nil)
            }
            
            
            func getPhoneInfo(_ index: Int) -> PhoneData? {
                return newContact.getPhoneByIndex(index)
            }
            
            func getAddressInfo(_ index: Int) -> AddressData? {
                return newContact.getAddressByIndex(index)
            }
            
            func getEmailInfo(_ index: Int) -> EmailData? {
                return newContact.getEmailByIndex(index)
            }
            
            func addDetailRow(_ section: Int) {
                if section > 0 {
                    var rowIndex: Int = 0
                    if section == 1 {
                        rowIndex = newContact.addPhone() - 1
                    }
                    else if section == 2 {
                        rowIndex = newContact.addEmail() - 1
                    }
                    else if section == 3 {
                        rowIndex = newContact.addAddress() - 1
                    }
                    let indexPath = IndexPath(row: rowIndex, section: section)
                    detailsTableView.insertRows(at: [indexPath], with: .automatic)
                }
            }
            
            func removeDetailRow(_ indexPath: IndexPath) {
                if indexPath.section == 1, let info = getPhoneInfo(indexPath.row) {
                    newContact.removeFromPhoneItems(info)
                }
                else if indexPath.section == 2, let info = getEmailInfo(indexPath.row) {
                    newContact.removeFromEmailItems(info)
                }
                else if indexPath.section == 3, let info = getAddressInfo(indexPath.row) {
                    newContact.removeFromAddressItems(info)
                }
                DispatchQueue.main.async {
                  
                    self.detailsTableView.deleteRows(at: [indexPath], with: .automatic)
                    self.detailsTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
                }
            }
        }
        
        extension EditDetailsViewController {
            func changeLabel(_ item: NSManagedObject?) {
                changeLabelSection = ""
                if let _ = item as? PhoneData {
                    changeLabelSection = "phone"
                }
                else if let _ = item as? EmailData {
                    changeLabelSection = "email"
                }
                else if let _ = item as? AddressData {
                    changeLabelSection = "address"
                }
            
                performSegue(withIdentifier: "changeLabel", sender: item)
            }
            
            
        }
        
        extension EditDetailsViewController {
            
            func isDynamicSection(_ section: Int) -> Bool {
                if section == 0 || (isExistingContact && (section == detailsTableView.numberOfSections - 1)) {
                    return false
                }
                else {
                    return true
                }
            }
            
            func isAddDetailsRow(indexPath: IndexPath) -> Bool {
                if isDynamicSection(indexPath.section) {
                    if indexPath.row == (detailsTableView.numberOfRows(inSection: indexPath.section) - 1) {
                        return true
                    }
                }
                return false
            }
            
            func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
                let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { [weak self] (action, indexPath) in
                    self?.removeDetailRow(indexPath)
                }
                return [deleteAction]
            }
            
            func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
                
                if isDynamicSection(indexPath.section) {
                    if isAddDetailsRow(indexPath: indexPath) {
                        return .insert
                    }
                    else {
                        return .delete
                    }
                }
                else {
                    return .none
                }
            }
            
            func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
                return isDynamicSection(indexPath.section)
            }
            
            func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
                if editingStyle == .delete {
                    // deleteRow(indexPath)
                }
                else if editingStyle == .insert {
                    addDetailRow(indexPath.section)
                }
            }
            
            func numberOfSections(in tableView: UITableView) -> Int {
                var count = TypeLabels.sections.count
                
                if isExistingContact {
                    count += 1
                }
                return count
            }
            
            func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                var rowCount = 1
                if section == 1 {
                    rowCount += newContact.phoneCount
                }
                else if section == 2 {
                    rowCount += newContact.emailCount
                }
                else if section == 3 {
                    rowCount += newContact.addressCount
                }
                return rowCount
            }
            
            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
                if isAddDetailsRow(indexPath: indexPath) {
                    
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "addDetailCell") {
                        cell.textLabel?.text = "add " + TypeLabels.sections[indexPath.section]
                        cell.textLabel?.font = Fonts.tableViewDetail
                        return cell
                    }
                }
                else if indexPath.section == 0 {
                    
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "editInfoCell") as? EditInfoTableViewCell {
                        cell.delegate = self
                        cell.selectionStyle = .none
                        cell.configureCell(newContact)
                        return cell
                    }
                }
                else if indexPath.section == 1 {
                    
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "editPhoneCell") as? EditPhoneTableViewCell {
                        cell.selectionStyle = .none
                        cell.delegate = self
                        if let info = getPhoneInfo(indexPath.row) {
                            cell.configureCell(info)
                        }
                        return cell
                    }
                }
                else if indexPath.section == 2 {
                    
                    if let info = getEmailInfo(indexPath.row), let cell = tableView.dequeueReusableCell(withIdentifier: "editEmailCell") as? EditEmailTableViewCell {
                        cell.selectionStyle = .none
                        cell.delegate = self
                        
                        cell.configureCell(info)
                        return cell
                    }
                }
                else if indexPath.section == 3 {
                    
                    if let info = getAddressInfo(indexPath.row), let cell = tableView.dequeueReusableCell(withIdentifier: "editAddressCell") as? EditAddressTableViewCell {
                        cell.selectionStyle = .none
                        cell.delegate = self
                        
                        cell.configureCell(info)
                        return cell
                    }
                }
                else if let cell = tableView.dequeueReusableCell(withIdentifier: "deleteContactCell") {
                    
                    let button = UIButton(frame: cell.frame)
                    button.contentEdgeInsets.left = 60
                    button.titleLabel?.font = Fonts.tableViewFooter
                    button.setTitle("Delete Contact", for: .normal)
                    button.setTitleColor(UIColor.red, for: .normal)
                    
                    button.addTarget(self, action: #selector(deleteContact), for: .touchUpInside)
                    button.titleLabel?.numberOfLines = 1
                    button.contentHorizontalAlignment = .left
                    cell.contentView.addSubview(button)
                    
                    return cell
                }
                return UITableViewCell()
            }
            
            func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                if (!isAddDetailsRow(indexPath: indexPath)) {
                    return rowHeights[indexPath.section]
                }
                else {
                    return tableView.rowHeight
                }
            }
        }
