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
    class func getKanjis(level:Int = 0) -> [Kanji] {
        var kList = [Kanji]()
        dbQueue.inDatabase({db in
            do{
                for row in try Row.fetchAll(db,"select * from kanji where story is not null"){
                    let kanji = Kanji()
                    
                    kanji.kanji = (row.value(named: "kanji") ?? "") as String
                    kanji.mean = (row.value(named: "mean") ?? "") as String
                    kanji.level = row.value(named: "level") as Int
                    kanji.kun = (row.value(named: "kun") ?? "") as String
                    kanji.on = (row.value(named: "on") ?? "") as String
                    //kanji.svgImg = row.value(named: "svg") as String
                    kanji.detail = (row.value(named: "deyail") ?? "") as String
                    kanji.comp = (row.value(named: "comp") ?? "") as String
                    kanji.compDetail = (row.value(named: "compDetail") ?? "") as String
                    kanji.examples = (row.value(named: "examples") ?? "") as String
                    //kanji.isFavorite = row.value(named: "favorite") as Bool
                    //kanji.didRemember = row.value(named: "remember") as Bool
                    kanji.image = (row.value(named: "story_image") ?? "") as String
                    kanji.story = (row.value(named: "story") ?? "") as String
                kList.append(kanji)
                
                
                    
                }
            }
            
            catch{
                print("getKanjis failed")
            }
            
            })
        return kList
    }
     public static func getInstance() -> DatabaseHelper{
    return dbHelper
    }
}


