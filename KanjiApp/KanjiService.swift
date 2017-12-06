//
//  KanjiService.swift
//  KanjiApp
//
//  Created by DT Dat on 2017/08/20.
//  Copyright © 2017 DT Dat. All rights reserved.
//

import Foundation
import GRDB
class KanjiService: NSObject{
    class func getKanjis(level:Int = 0, callback: @escaping ([Kanji]) -> Void){
        var kList = [Kanji]()
        DatabaseHelper.dbQueue.inDatabase({db in
            do{
                for row in try Row.fetchAll(db,"select * from kanji where level = \(level)"){
                    let kanji = Kanji()
                    kanji.kanji = (row["kanji"] ?? "") as String
                    kanji.mean = (row["mean"] ?? "") as String
                    kanji.level = row["level"] as Int
                    kanji.kunyomi = (row["kunyomi"] ?? "") as String
                    kanji.onyomi = (row["onyomi"] ?? "") as String
                    //kanji.svgImg = row.value(named: "svg") as String
                    kanji.detail = (row["deyail"] ?? "") as String
                    kanji.comp = (row["comp"] ?? "") as String
                    kanji.compDetail = (row["compDetail"] ?? "") as String
                    kanji.examples = (row["examples"] ?? "") as String
                    //kanji.isFavorite = row.value(named: "favorite") as Bool
                    //kanji.didRemember = row.value(named: "remember") as Bool
                    kanji.story_image = (row["story_image"] ?? "") as String
                    kanji.story = (row["story"] ?? "") as String
                    kList.append(kanji)
                    print(kanji.kanji)
                }
                print("finished")
                callback(kList)
            }
                
            catch{
                print("getKanjis failed")
            }
            
        })
}
    class func getKanjis(kanji:String, callback: @escaping ([Kanji]) -> Void)  {
        var kList = [Kanji]()
        DatabaseHelper.dbQueue.inDatabase({db in
            do{
              
                for row in try Row.fetchAll(db,"select * from kanji where kanji like '\(kanji)'"
                    + " OR mean like '\(kanji)'"
                    + " OR kunyomi like '%\(kanji)%'"
                    + " OR onyomi like '%\(kanji)%'"
                    + " OR level = '\(kanji)'"
                     + " AND story IS NOT NULL"){
                    let kanji = Kanji()
                    kanji.kanji = (row["kanji"] ?? "") as String
                    kanji.mean = (row["mean"] ?? "") as String
                    kanji.level = (row["level"] ?? 0) as Int
                    kanji.kunyomi = (row["kunyomi"] ?? "") as String
                    kanji.onyomi = (row["onyomi"] ?? "") as String
                    kanji.svgImg = (row["svg"] ?? "") as String
                    kanji.detail = (row["deyail"] ?? "") as String
                    kanji.comp = (row["comp"] ?? "") as String
                    kanji.compDetail = (row["compDetail"] ?? "") as String
                    kanji.examples = (row["examples"] ?? "") as String
                    kanji.isFavorite = (row["favorite"] ?? false) as Bool
                    kanji.didRemember = (row["remember"] ?? false) as Bool
                    kanji.story_image = (row["story_image"] ?? "") as String
                    kanji.story = (row["story"] ?? "") as String
                    kList.append(kanji)
                }
                callback(kList)
            }
                
            catch{
                print("getKanjis failed")
            }
            
        })
    }
}
