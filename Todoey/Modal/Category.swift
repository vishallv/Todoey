//
//  Category.swift
//  Todoey
//
//  Created by Vishal Lakshminarayanappa on 2/28/19.
//  Copyright © 2019 Vishal Lakshminarayanappa. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    
    @objc dynamic var name : String = ""
    
    @objc dynamic var color : String = ""
    let items = List<Item>()
}
