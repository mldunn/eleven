//
//  ContactsViewController.swift
//  ESContacts
//
//  Created by michael dunn on 2/19/18.
//  Copyright © 2018 michael dunn. All rights reserved.
//

import UIKit

let CHANGE_NOTIFICATION = "ContactChanged"

class ContactsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var itemTableView: UITableView!
    
    var contactManager = ContactHelper()
    var sectionHeaders = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Contacts"
        
        itemTableView.register(UITableViewCell.self, forCellReuseIdentifier: "contactCell")
        itemTableView.register(UITableViewCell.self, forCellReuseIdentifier: "footerCell")
        
        if Util.checkImport("importJSON") {
            _ = contactManager.importJSON()
        }
        
        
        sectionHeaders = contactManager.letterKeys()
        itemTableView.delegate = self
        itemTableView.dataSource = self
        
        itemTableView.tableFooterView = UIView()
        
        // listen for contact changed
        NotificationCenter.default.addObserver(self, selector: #selector(refreshView), name: Notification.Name(rawValue: CHANGE_NOTIFICATION), object: nil)
        
    }
    
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addContact(_ sender: Any) {
        performSegue(withIdentifier: "addNewContact", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails" {
            if let vc = segue.destination as? DetailsViewController, let contact = sender as? ContactData {
                vc.contact = contact
           }
        }
        else if segue.identifier == "addNewContact" {
            if let nav = segue.destination as? UINavigationController {
                if let vc = nav.viewControllers.first as? EditDetailsViewController {
                    //xx           vc.delegate = self
                }
            }
        }
    }
    
    func showDetails(_ contact: ContactData) {
        performSegue(withIdentifier: "showDetails", sender: contact)
    }
    
    
    
    func getItemCountDisplay() -> String {
        let count = contactManager.totalItems
        var footerText = " Contacts"
        if count == 1 {
            footerText = " Contact"
        }
        return String(count) + footerText
    }
    
    @objc func refreshView() {
        DispatchQueue.main.async {
            self.sectionHeaders = self.contactManager.letterKeys()
            print(self.sectionHeaders)
            self.itemTableView.reloadData()
            // self.updateFooter()
        }
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
            if let items = contactManager.itemsForKey(letter: key) {
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
            return contactManager.numberOfItems(letter: key)
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == sectionHeaders.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "footerCell", for: indexPath)
            cell.textLabel?.text = getItemCountDisplay()
            cell.textLabel?.textAlignment = .center
            cell.selectionStyle = .none
            return cell
        }
        else if let item = getItem(indexPath) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
            cell.textLabel?.text = item.displayName
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
}





