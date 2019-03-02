//
//  SwipeTableViewController.swift
//  Todoey
//
//  Created by Vishal Lakshminarayanappa on 3/2/19.
//  Copyright © 2019 Vishal Lakshminarayanappa. All rights reserved.
//

import UIKit
import SwipeCellKit

class SwipeTableViewController: UITableViewController , SwipeTableViewCellDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SwipeTableViewCell
        
        
        
        cell.delegate = self
        return cell
        
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            // handle action by updating model with deletion
            // print("Item Deleted")
            
            //print(self.categoryArray?[indexPath.row])
            
//            if let categoryForDeletion = self.categoryArray?[indexPath.row]{
//                do{
//                    try  self.realm.write {
//                        self.realm.delete(categoryForDeletion)
//                    }}
//                catch {
//                    print("Error Deleting \(error)")
//                }
                // self.tableView.reloadData()
            
            self.updateModal(at: indexPath)
          //  print("Sucess Delteling")
          
            
        }
        
        // customize the action appearance
        deleteAction.image = UIImage(named: "delete-Icon")
        
        return [deleteAction]
    }
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        return options
    }
    
    func updateModal (at indexPath : IndexPath){
        
    }

}
