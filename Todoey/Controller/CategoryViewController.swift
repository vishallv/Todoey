//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Vishal Lakshminarayanappa on 2/27/19.
//  Copyright © 2019 Vishal Lakshminarayanappa. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework


class CategoryViewController: SwipeTableViewController {
    
    let realm =  try! Realm()
    
    
    
    var   categoryArray :Results<Category>?
  //  var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        loadCategory()
        tableView.rowHeight = 80
      //  tableView.estimatedRowHeight = 80.0
        tableView.separatorStyle = .none
        
        
    }
    
    
    
    // MARK: - Table view data source
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! SwipeTableViewCell
//        cell.delegate = self
//        return cell
//    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! SwipeTableViewCell
        
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        cell.textLabel?.text = categoryArray?[indexPath.row].name ?? "No Category Added"
    //  cell.backgroundColor = UIColor.randomFlat
        
        
        guard let categoryColor = UIColor(hexString: (categoryArray?[indexPath.row].color)!) else {fatalError()}
        cell.backgroundColor = categoryColor
        cell.textLabel?.textColor = ContrastColorOf(categoryColor, returnFlat: true)
        
//        cell.delegate = self
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categoryArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoLisTViewController
        if let indexpath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categoryArray?[indexpath.row]
        }
    }
    
    // Mark - New Category
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var  textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            
            
            let newCategory = Category()
            newCategory.name = textField.text!
           newCategory.color = UIColor.randomFlat.hexValue()
          //  self.categoryArray.append(newCategory)
            
            self.save(category: newCategory)
            //  self.tableView.reloadData()
            
        }
        
        
        alert.addTextField { (addtextfield) in
            
            addtextfield.placeholder = "New Category"
            textField = addtextfield
            
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    
    func save(category : Category){
        
        do {
//            print("Sucessful Save")
            try realm.write {
                realm.add(category)
            }
        }
        catch{
            print("Unable to Save \(error)")
            
        }
        tableView.reloadData()
    }
    func loadCategory (){
        
        
        categoryArray = realm.objects(Category.self)
        
//        let request : NSFetchRequest<Category> = Category.fetchRequest()
//
//        do{
//
//            categoryArray =  try context.fetch(request)
//
//
//        }
//        catch{
//
//
//            print("Unable to load Data \(error)")
//        }
//        
//        tableView.reloadData()
//
//    }
//
    
    
    }
    
    
    override func updateModal(at indexPath: IndexPath) {
        if let categoryForDeletion = categoryArray?[indexPath.row]{
                            do{
                                try  self.realm.write {
                                    self.realm.delete(categoryForDeletion)
                                }}
                            catch {
                                print("Error Deleting \(error)")
                            }
        }}
    
}



