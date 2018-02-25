//
//  ContactsViewController.swift
//  ESContacts
//
//  Created by michael dunn on 2/19/18.
//  Copyright © 2018 michael dunn. All rights reserved.
//

import UIKit



class ContactsViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var itemTableView: UITableView!
    
    var sectionHeaders = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Contacts"
        
        itemTableView.register(UITableViewCell.self, forCellReuseIdentifier: "contactCell")
        itemTableView.register(UITableViewCell.self, forCellReuseIdentifier: "footerCell")
        
        //
        // check if we already did an import, if not do one here
        //
        if Util.checkImport("importJSON") {
            _ = ContactHelper.importJSON()
        }
        
        //
        // build out the table view
        //
        sectionHeaders = ContactHelper.letterKeys()
        itemTableView.delegate = self
        itemTableView.dataSource = self
        itemTableView.tableFooterView = UIView()
        
        //
        // set up observers for notifcations that a contact has changed or been deleted
        // so we can refresh the view
        //
        NotificationCenter.default.addObserver(self, selector: #selector(contactSaved), name: Notification.Name(rawValue: SAVE_NOTIFICATION), object: nil)
    
        NotificationCenter.default.addObserver(self, selector: #selector(contactDeleted), name: Notification.Name(rawValue: DELETE_NOTIFICATION), object: nil)
    }
    
    //
    // make sure we refresh the view on the main thread
    //
    func refreshView() {
        DispatchQueue.main.async {
            self.sectionHeaders = ContactHelper.letterKeys()
            self.itemTableView.reloadData()
        }
    }
    
    @objc func contactDeleted() {
        // if a contact was deleted, pop the "detail" view since its no longer valid
        navigationController?.popToRootViewController(animated: true)
        refreshView()
    }
    
    @objc func contactSaved() {
        refreshView()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //
    // action for the add (plus sign) in the navigation bar
    //
    
    @IBAction func addContact(_ sender: Any) {
        performSegue(withIdentifier: "addNewContact", sender: self)
    }
    
    //
    // use the segue to pass the selected contact to the "detail" view
    //
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails" {
            if let vc = segue.destination as? DetailsViewController, let contact = sender as? ContactData {
                vc.contact = contact
           }
        }
    }
    
    //
    // helper functions for the table view
    //
    
    func showDetails(_ contact: ContactData) {
        performSegue(withIdentifier: "showDetails", sender: contact)
    }
    
    func getItemCountDisplay() -> String {
        let count = ContactHelper.totalItems
        var footerText = " Contacts"
        if count == 1 {
            footerText = " Contact"
        }
        return String(count) + footerText
    }
    
    func letterForSection(_ index: Int) -> String? {
        guard index >= 0  && index < sectionHeaders.count else {
            return nil
        }
        return sectionHeaders[index]
    }
    
    func getItem(_ indexPath: IndexPath) -> ContactData? {
        var item: ContactData?
        if let key = letterForSection(indexPath.section) {
            if let items = ContactHelper.itemsForKey(letter: key) {
                guard indexPath.row >= 0 && indexPath.row < items.count else {
                    return nil
                }
                item = items[indexPath.row] as? ContactData
            }
        }
        return item
    }
}


//
// tableview delegate/datasource functions
//
extension ContactsViewController {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionHeaders.count + 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section < sectionHeaders.count {
            return letterForSection(section)
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == sectionHeaders.count {
            return 1
        }
        else if let key = letterForSection(section) {
            return ContactHelper.numberOfItems(letter: key)
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == sectionHeaders.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "footerCell", for: indexPath)
            cell.textLabel?.text = getItemCountDisplay()
            cell.textLabel?.font = Fonts.tableViewItem
            cell.textLabel?.textAlignment = .center
            cell.selectionStyle = .none
            return cell
        }
        else if let item = getItem(indexPath) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
            cell.textLabel?.text = item.displayName
            cell.textLabel?.font = Fonts.tableViewItem
            cell.textLabel?.highlightAtIndex(index: Int(item.sortIndex), bold: true, color: nil)
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = getItem(indexPath) {
            showDetails(item)
        }
    }
    
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        if let index = sectionHeaders.index(of: title) {
            return index
        }
        return -1
        
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return letterHeaders
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = Fonts.tableViewItemBold
        header.textLabel?.frame = header.frame
    }
}





