//
//  ViewController.swift
//  Todoey
//
//  Created by Vishal Lakshminarayanappa on 2/25/19.
//  Copyright © 2019 Vishal Lakshminarayanappa. All rights reserved.
//

import UIKit

class ToDoLisTViewController: UITableViewController {

    
    var itemArray = [Item]()
   // let defaults : UserDefaults = .standard
    
       let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
     
       // print(dataFilePath)
        
//        let newItem = Item()
//        newItem.title = "One"
//        itemArray.append(newItem)
//
//        let newItem2 = Item()
//        newItem2.title = "Two"
//        itemArray.append(newItem2)
//
//        let newItem3 = Item()
//        newItem3.title = "Three"
//        itemArray.append(newItem3)
        
        loadData()
        
//        if let items = defaults.array(forKey: "ToDoListArray") as? [Item]
//        {
//            itemArray = items
//        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemList", for: indexPath)
       let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        
        cell.accessoryType = (item.done == true) ? .checkmark : .none
//        if item.done == true{
//            cell.accessoryType = .checkmark
//        }else{
//            cell.accessoryType = .none
//        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return itemArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
       // tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
    
        
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark
//        {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        }else
//        {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
        saveItems()
       
        tableView.deselectRow(at: indexPath, animated: true )
    }
   
    
    
    
    @IBAction func addButtonPress(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
           // print("Success")
            
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
         //   self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            self.saveItems()
           
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Todoey"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    func saveItems(){
        let encoder = PropertyListEncoder()
        
        do{
            let data =  try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
            
        }catch{
            print("Unable to encode \(error)")
        }
        
        
        tableView.reloadData()
        
    }
    func loadData(){
        
        if  let data =  try? Data(contentsOf: dataFilePath!){
        let decoder = PropertyListDecoder()
            do{
            try itemArray = decoder.decode([Item].self, from: data)
            }
            catch{
                print(error)
            }
            }
        
        
    }

}

