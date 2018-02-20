//
//  ContactsViewController.swift
//  ESContacts
//
//  Created by michael dunn on 2/19/18.
//  Copyright © 2018 michael dunn. All rights reserved.
//

import UIKit

protocol ManageContactDelegate {
    func contactChanged(_ contact: Contact)
    func contactDeleted(_ contact: Contact)
}

class ContactsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ManageContactDelegate  {
    
    @IBOutlet weak var itemTableView: UITableView!
    
    var contactManager = ContactsManager()
    var sectionHeaders = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Contacts"
        
        if Util.checkOnetimeKey("importJSON") {
            _ = contactManager.importJSON()
        }
        else {
            _ = contactManager.load()
        }
        
        sectionHeaders = contactManager.letterKeys()
        itemTableView.delegate = self
        itemTableView.dataSource = self
        
        itemTableView.tableFooterView = UIView()
       
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
            if let vc = segue.destination as? DetailsViewController, let contact = sender as? Contact {
                vc.contact = contact
                vc.delegate = self
            }
        }
        else if segue.identifier == "addNewContact" {
            if let nav = segue.destination as? UINavigationController {
                if let vc = nav.viewControllers.first as? EditDetailsViewController {
                    vc.delegate = self
                }
            }
        }
    }
    
    func showDetails(_ contact: Contact) {
        performSegue(withIdentifier: "showDetails", sender: contact)
    }
    
   
    
    func getItemCountDisplay() -> String {
        let count = contactManager.count
        var footerText = " Contacts"
        if count == 1 {
            footerText = " Contact"
        }
        return String(count) + footerText
    }
    
    func refreshView() {
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
    
    func getItem(_ indexPath: IndexPath) -> Contact? {
        var item: Contact?
        if let key = letterForSection(indexPath.section) {
            if let items = contactManager.itemsForKey(letter: key) {
                guard indexPath.row >= 0 && indexPath.row < items.count else {
                    return nil
                }
                item = items[indexPath.row]
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
            if let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell") {
                cell.textLabel?.text = getItemCountDisplay()
                cell.textLabel?.textAlignment = .center
                cell.selectionStyle = .none
                return cell
            }
        }
        else if let item = getItem(indexPath) {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell") {
                cell.textLabel?.text = item.displayName
                cell.textLabel?.highlightTerm(term: item.sortName, bold: true, color: nil)
                cell.selectionStyle = .none
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = getItem(indexPath) {
            showDetails(item)
        }
    }
}

extension ContactsViewController {
    func contactChanged(_ contact: Contact) {
        print("contactChanged")
       
            
        self.contactManager.updateContact(contact)
        self.refreshView()
        
    }
    
    func contactDeleted(_ contact: Contact) {
        contactManager.deleteContact(contact)
        navigationController?.popToRootViewController(animated: true)
        refreshView()
    }
}




