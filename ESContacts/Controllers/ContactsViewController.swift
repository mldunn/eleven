//
//  ContactsViewController.swift
//  ESContacts
//
//  Created by michael dunn on 2/19/18.
//  Copyright © 2018 michael dunn. All rights reserved.
//

import UIKit



class ContactsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var itemTableView: UITableView!
    
    var sectionHeaders = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Contacts"
        navigationController?.navigationBar.backgroundColor = Colors.navBar
        
        itemTableView.register(UITableViewCell.self, forCellReuseIdentifier: "contactCell")
        itemTableView.register(UITableViewCell.self, forCellReuseIdentifier: "footerCell")
        
        if Util.checkImport("importJSON") {
            _ = ContactHelper.importJSON()
        }
        
        sectionHeaders = ContactHelper.letterKeys()
        itemTableView.delegate = self
        itemTableView.dataSource = self
        itemTableView.tableFooterView = UIView()
        
        // listen for contact changed
        NotificationCenter.default.addObserver(self, selector: #selector(contactSaved), name: Notification.Name(rawValue: SAVE_NOTIFICATION), object: nil)
        // listen for contact deleted
        NotificationCenter.default.addObserver(self, selector: #selector(contactDeleted), name: Notification.Name(rawValue: DELETE_NOTIFICATION), object: nil)
    }
    
    @objc func contactDeleted() {
        navigationController?.popToRootViewController(animated: true)
        refreshView()
    }
    
    @objc func contactSaved() {
        refreshView()
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
    }
    
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
    
    func refreshView() {
        DispatchQueue.main.async {
            self.sectionHeaders = ContactHelper.letterKeys()
            self.itemTableView.reloadData()
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
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        
        return letterHeaders
    }
}





