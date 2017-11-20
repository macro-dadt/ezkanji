//
//  Jlpt.swift
//  KanjiApp
//
//  Created by DT Dat on 2017/11/04.
//  Copyright © 2017 DT Dat. All rights reserved.
//

import Foundation
enum Type {
    case kanji
    case word
}
class Jlpt: NSObject {
    var type: Type = .kanji
    var level: Int = 3
    var source = ""
}
