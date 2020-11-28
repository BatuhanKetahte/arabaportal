//
//  ToDoRealmModel.swift
//  Cargram
//
//  Created by Batuhan Ketahte 28.11.2020
//  Copyright © 2020 Batuhan Ketahte. All rights reserved.
//

import RealmSwift

class ToDoRealmModel: Object {
    @objc dynamic var toDoTitle: String?
    @objc dynamic var toDoDescription: String?
    @objc dynamic var toDoCompletted = false
    let picArray = List<Data>()
    let test  = [String]()
    @objc dynamic var deathline: Double = 0.0
    @objc dynamic var toDoDateShow = false
    
}
