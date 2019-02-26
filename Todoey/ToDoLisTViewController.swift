//
//  ViewController.swift
//  Todoey
//
//  Created by Vishal Lakshminarayanappa on 2/25/19.
//  Copyright © 2019 Vishal Lakshminarayanappa. All rights reserved.
//

import UIKit

class ToDoLisTViewController: UITableViewController {

    
    var itemArray = ["One","Two","Three"]
    let defaults : UserDefaults = .standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let items = defaults.array(forKey: "ToDoListArray") as? [String]
        {
            itemArray = items
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemList", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell 
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return itemArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
       // tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true )
    }
   
    
    
    
    @IBAction func addButtonPress(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
           // print("Success")
            self.itemArray.append(textField.text!)
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            
            self.tableView.reloadData()
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Todoey"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    

}

