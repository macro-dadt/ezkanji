//
//  DatabaseHelper.swift
//  KanjiApp
//
//  Created by DT Dat on 2017/08/13.
//  Copyright © 2017 DT Dat. All rights reserved.
//

import GRDB
class DatabaseHelper {
   static var dbHelper = DatabaseHelper()
    static var dbQueue : DatabaseQueue = {
        var db : DatabaseQueue = DatabaseQueue()
        do{
        db = try DatabaseQueue(path: Bundle.main.path(forResource: "database", ofType: "sqlite")!)
        }
        catch{
        print("conect to database false")
        }
        return db
    }()
     public static func getInstance() -> DatabaseHelper{
    return dbHelper
    }
}


