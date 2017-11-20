//
//  JlptService.swift
//  KanjiApp
//
//  Created by DT Dat on 2017/11/04.
//  Copyright © 2017 DT Dat. All rights reserved.
//

import Foundation
class JlptService: NSObject {
    class func getData(jlpt: Jlpt,  callback: @escaping ([AnyObject]) -> Void) {
        switch jlpt.type {
        case .kanji:
            KanjiService.getKanjis(level: jlpt.level, callback: {kanjis in
                callback(kanjis)
            })
        case .word:
            print("word")
        }
    }
}
