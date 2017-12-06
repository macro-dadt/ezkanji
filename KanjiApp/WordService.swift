//
//  WordService.swift
//  KanjiApp
//
//  Created by DT Dat on 2017/11/04.
//  Copyright © 2017 DT Dat. All rights reserved.
//

import Foundation
import GRDB
class WordService: NSObject {
    class func getWords(level:Int = 0, source: String, callback: @escaping ([Word]) -> Void){
        var words = [Word]()
        DatabaseHelper.dbQueue.inDatabase({db in
            do{
                for row in try Row.fetchAll(db,"select * from word where level = \(level) OR source like'%\(source)%'"){
                    let word = Word()
                    word.story = (row["story"] ?? "") as String
                    word.mean = (row["mean"] ?? "") as String
                    word.story_image = row["story_image"]  as String
                    word.level = (row["level"] ?? 0) as! Int
                    words.append(word)
                }
                callback(words)
            }
                
            catch{
                print("getWords failed")
            }
            
        })
    }
}
