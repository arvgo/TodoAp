//
//  ViewController.swift
//  TodoAp
//
//  Created by RAG on 28/03/2019.
//  Copyright © 2019 RAG. All rights reserved.
//

import UIKit

class ToDoListVc: UITableViewController {
    
    var itemArray = ["Buy Eggs", "Book Leave", "Finish testing"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //MARK - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    //MARK - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("Item to do is: ", itemArray[indexPath.row])
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            // Remove checkmark when cell selected
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            // Add checkmark when cell selected
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        // Flashes grey only briefly when selected
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Add New Itemss
    @IBAction func addBtnPressed(_ sender: Any) {
        var textField = UITextField()
        let alert1 = UIAlertController(title: "Add New To Do Item", message: "", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "Add Item", style: .default) { (action) in
        // What will happen once user clicks Add Item btn on our UIAlert
//           print("Txtfield: ", textField.text)
            self.itemArray.append(textField.text!)
            print(self.itemArray)
            self.tableView.reloadData()
            
        }
        
        alert1.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            // Allows extension of alterTextField scope to outside of alert1.addTextField closure
            textField = alertTextField
        }
        alert1.addAction(action1)
        present(alert1, animated: true, completion: nil)
    }
}

