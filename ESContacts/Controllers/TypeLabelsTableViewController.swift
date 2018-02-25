//
//  TypeLabelsTableViewController.swift
//  ESContacts
//
//  Created by michael dunn on 2/25/18.
//  Copyright © 2018 michael dunn. All rights reserved.
//

import UIKit
import CoreData

//
// Using a UITableViewController here because there is not much else going on in this view
//

class TypeLabelsTableViewController: UITableViewController {
    
    var selectedIndex = -1
    var labels: [String] = []
    var type: String = ""
    var data: Any?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Label"
        
        if let navigationBar = navigationController?.navigationBar {
            
            navigationBar.tintColor = Colors.customBlue
            navigationBar.barTintColor = Colors.navBar
            
        }
        
        //
        // get the array of labels
        //
        labels = TypeLabels.values(forType: type)
        
        if let data = data as? NSManagedObject {
            
            if let label = data.value(forKey: "type") as? String {
                selectedIndex = labels.index(of: label) ?? -1
            }
        }
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "labelCell")
        
    }
    
    //
    // the view controller gets dismissed if a cell is selected or if Cancel is tapped
    //
    
    func dismissVC(_ selected: Int) {
        if selected >= 0 && selected < labels.count {
            let value = labels[selected]
            if let item = data as? NSManagedObject {
                item.setValue(value, forKey: "type")
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismissVC(-1)
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row != selectedIndex {
            //
            // change the checkmark accesssory (though we dismiss right away so really not necessary)
            //
            if let prev = tableView.cellForRow(at: IndexPath(row: selectedIndex, section: indexPath.section)) {
                prev.accessoryType = .none
            }
            if let sel = tableView.cellForRow(at: indexPath) {
                sel.accessoryType = .checkmark
                dismissVC(indexPath.row)
            }
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labels.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "labelCell", for: indexPath)

        cell.textLabel?.text = labels[indexPath.row]
        cell.textLabel?.font = Fonts.tableViewItem
        if indexPath.row == selectedIndex {
            cell.accessoryType = .checkmark
        }
        return cell
    }
    

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
    
}
