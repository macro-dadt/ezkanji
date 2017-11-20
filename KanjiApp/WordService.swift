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
                    word.story = (row.value(named: "story") ?? "") as String
                    word.mean = (row.value(named: "mean") ?? "") as String
                    word.story_image = row.value(named: "story_image" ) as String
                    word.level = (row.value(named: "level") ?? 0) as! Int
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
