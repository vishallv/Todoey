//
//  AppDelegate.swift
//  Todoey
//
//  Created by Vishal Lakshminarayanappa on 2/25/19.
//  Copyright © 2019 Vishal Lakshminarayanappa. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
       // print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String)
        
//   print(Realm.Configuration.defaultConfiguration.fileURL)
//
//        let data = Data()
//        data.name = "Vishal"
//        data.age = 22
        
        
//        do{
//        let realm =  try Realm()
////           try  realm.write {
////                realm.add(data)
////            }
//        }
//        catch{
//            print("error Installing Realm \(error)")
//        }
        
        
        return true
    }


    func applicationWillTerminate(_ application: UIApplication) {
        
        self.saveContext()
    }

    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "CoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

