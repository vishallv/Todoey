//
//  ViewController.swift
//  Todoey
//
//  Created by Vishal Lakshminarayanappa on 2/25/19.
//  Copyright © 2019 Vishal Lakshminarayanappa. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class ToDoLisTViewController: SwipeTableViewController{
    
    
    var itemArray :Results<Item>?
    let realm = try! Realm()
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var selectedCategory : Category? {
        didSet{
            loadData()
        }
    }
    // let defaults : UserDefaults = .standard
    
    //  let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")
    //    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        // Do any additional setup after loading the view, typically from a nib.
        
        //   print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        
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
        
        //        loadData()
        
        //        if let items = defaults.array(forKey: "ToDoListArray") as? [Item]
        //        {
        //            itemArray = items
        //        }
        
        tableView.rowHeight = 80.0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        guard let color = selectedCategory?.color else {fatalError()}
        
        title = selectedCategory?.name
        navBarUpdate(color: color)
        
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navBarUpdate(color: "1D9BF6")
    }
    
    
    func navBarUpdate (color colorHex :String){
        guard let navBar = navigationController?.navigationBar else {fatalError("Nav Bar not loaded")}
        
        guard let navBarColor = UIColor(hexString: colorHex) else {fatalError()}
        
        
        navBar.tintColor = ContrastColorOf(navBarColor, returnFlat: true)
        navBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : ContrastColorOf(navBarColor, returnFlat: true)]
        navBar.barTintColor = navBarColor
        searchBar.barTintColor = navBarColor
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //    let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemList", for: indexPath)
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        if  let item = itemArray?[indexPath.row]{
            
            cell.textLabel?.text = item.title
            
            if let colour = UIColor(hexString: (selectedCategory?.color)!)?.darken(byPercentage: CGFloat(indexPath.row)/CGFloat((itemArray?.count)!)){
                cell.backgroundColor = colour
                cell.textLabel?.textColor = ContrastColorOf(colour, returnFlat: true)
            }
            
            
            cell.accessoryType = (item.done == true) ? .checkmark : .none
        }
        else {
            cell.textLabel?.text = "No Item Added"
        }
        //        if item.done == true{
        //            cell.accessoryType = .checkmark
        //        }else{
        //            cell.accessoryType = .none
        //        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray?.count ?? 1
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        
        if let item = itemArray?[indexPath.row]{
            
            do {
                try realm.write {
                    item.done = !item.done
                    
                }}
            catch{
                print(error)
            }
            
            
        }
        tableView.reloadData()
        
        
        // tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        //        context.delete(itemArray[indexPath.row])
        //        itemArray.remove(at: indexPath.row)
        
        //        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        
        //        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark
        //        {
        //            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        //        }else
        //        {
        //            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        //        }
        //        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true )
    }
    
    
    
    
    @IBAction func addButtonPress(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            // print("Success")
            
            
            
            if let currentCategory = self.selectedCategory{
                
                do {
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = textField.text!
                        
                        newItem.dateCreated = Date()
                        currentCategory.items.append(newItem)
                    }
                    
                }
                catch{
                    print("Error Saving Item \(error)")
                }
                self.tableView.reloadData()
            }
            
            //  newItem.parentCategory = self.selectedCategory
            // self.itemArray.append(newItem)
            
            //            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            //            self.saveItems( )
            
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Todoey"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    
    //    func saveItems(){
    ////        let encoder = PropertyListEncoder()
    //
    //        do{
    ////            let data =  try encoder.encode(itemArray)
    ////            try data.write(to: dataFilePath!)
    //          try  context.save()
    //
    //
    //
    //        }catch{
    //            print("Eroor savinf Item \(error)")
    //        }
    //
    //
    //        tableView.reloadData()
    //
    //    }
    func loadData(){
        
        itemArray = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        //
        //      //  let request : NSFetchRequest<Item> = NSFetchRequest<Item>
        //
        //        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", (selectedCategory?.name)!)
        //
        //        if let additionalPredicate = predicate{
        //            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate,additionalPredicate])
        //        }else{
        //            request.predicate = categoryPredicate
        //        }
        ////       - let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate,predicate])
        ////
        ////       - request.predicate = compoundPredicate
        //        do {
        //            itemArray = try context.fetch(request)
        //        }
        //        catch{
        //            print("Error Fetching : \(error)")
        //        }
        //        tableView.reloadData()
    }
    
    override func updateModal(at indexPath: IndexPath) {
        if let currentItem = itemArray?[indexPath.row]{
            
            do{
                try realm.write {
                    realm.delete(currentItem)
                }
            }
            catch{
                print("unable to delete item \(error)")
            }
            
        }
    }
    
    
}

extension ToDoLisTViewController : UISearchBarDelegate{
    //
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        itemArray = itemArray?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()
    }
    
    //
    //        let request : NSFetchRequest <Item> = Item.fetchRequest()
    //        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
    //
    //
    //         request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
    //
    //
    //
    //
    //        //  print(searchBar.text!)
    //
    ////     -   do {
    ////      -      itemArray = try context.fetch(request)
    ////       - }
    ////        -catch{
    ////                    print("Error Fetching : \(error)")
    //
    ////        }
    //      // - loadData()
    //
    //        loadData(with: request, predicate: predicate)
    //
    ////      -  tableView.reloadData()
    //    }
    //
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0{
            loadData()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            
        }
    }
    //}
    //
}
