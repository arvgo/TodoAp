//
//  ViewController.swift
//  TodoAp
//
//  Created by RAG on 28/03/2019.
//  Copyright © 2019 RAG. All rights reserved.
//

import UIKit

class ToDoListVc: UITableViewController {
    
//    var itemArray = ["Buy Eggs", "Book Leave", "Finish testing"]
    // Create array of Item Objects
    var itemArray = [Item]()
    
    // For data persistence
//    let defaults = UserDefaults.standard
    
    // Creata path to new pList
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

    override func viewDidLoad() {
        super.viewDidLoad()
//        print("File Path >> ", dataFilePath)
        
        //Remove for decodable method
//        let newItem = Item()
//        newItem.title = "Marco"
//        itemArray.append(newItem)
//
//        let newItem2 = Item()
//        newItem2.title = "Buy Eggs"
//        itemArray.append(newItem2)
//
//        let newItem3 = Item()
//        newItem3.title = "Book Leave 2t"
//        itemArray.append(newItem3)
//
//        let newItem4 = Item()
//        newItem4.title = "Finish testing 4t"
//        itemArray.append(newItem4)

        loadItems()
        // Update array with user default --> contains after app terminated
        // retrieving an array of strings here
//        if let items = defaults.array(forKey: "ToDoListArray") as? [String] {
//            itemArray = items
//        }
        // We're now retrieving an array of Item objects
//        if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {
//            itemArray = items
//        }
        
    }
    
    //MARK: - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    // Method is only called initially when tableview is loaded up
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        
        // This way if accesing a string from array
//        cell.textLabel?.text = itemArray[indexPath.row]
        // TO allow access to array of item object
        cell.textLabel?.text = item.title
        
        // value = condition ? valueIfTrue : valueIfFalse
        cell.accessoryType = item.done ? .checkmark : .none
        // Equivalent to --->
//        if item.done == true {
//            // Add checkmark when cell selected
//            cell.accessoryType = .checkmark
//        } else {
//            // Remove checkmark when cell selected
//            cell.accessoryType = .none
//        }
        
        return cell
    }
    
    //MARK: - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("Item to do is: ", itemArray[indexPath.row])
        //Toggling done property
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        // Equivalent to --->
//        if itemArray[indexPath.row].done == false {
//            itemArray[indexPath.row].done = true
//        } else {
//            itemArray[indexPath.row].done = false
//        }
        
        
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
//            // Remove checkmark when cell selected
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        } else {
//            // Add checkmark when cell selected
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
        self.saveItems()
//        tableView.reloadData()

        // Flashes grey only briefly when selected
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Add New Itemss
    @IBAction func addBtnPressed(_ sender: Any) {
        var textField = UITextField()
        let alert1 = UIAlertController(title: "Add New To Do Item", message: "", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "Add Item", style: .default) { (action) in
        // What will happen once user clicks Add Item btn on our UIAlert
//           print("Txtfield: ", textField.text)
            
            let newItm = Item()
            newItm.title = textField.text!
            self.itemArray.append(newItm)
//            self.itemArray.append(textField.text!)
            // Save updated item array to our user default
//            self.defaults.set(self.itemArray, forKey: "ToDoListArray")

//            print(self.itemArray)
//            self.tableView.reloadData()
            self.saveItems()
            
        }
        
        alert1.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            // Allows extension of alterTextField scope to outside of alert1.addTextField closure
            textField = alertTextField
        }
        alert1.addAction(action1)
        present(alert1, animated: true, completion: nil)
    }
    
    func saveItems() {
        
        // Instead of user defaults, we can also use encoder for similar purpose
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding array")
        }
        self.tableView.reloadData()
    }
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
               itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Decoding error")
            }
        }
    }
}

