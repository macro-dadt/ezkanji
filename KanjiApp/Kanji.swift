//
//  Kanji.swift
//  KanjiApp
//
//  Created by DT Dat on 2017/07/09.
//  Copyright © 2017 DT Dat. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class Kanji: NSObject {
    dynamic var furigana = ""
    dynamic var romanji = ""
    dynamic var kanji = ""
    dynamic var vietnamese = ""
    dynamic var favourite = false
    dynamic var vocabularyID = ""
    
    convenience init(json: JSON) {
        self.init()
        if let aFurigana = json["furigana"].string {
            self.furigana = aFurigana
        } else {
            self.furigana = ""
        }
        if let aRomanji = json["romanji"].string {
            self.romanji = aRomanji
        } else {
            self.romanji = ""
        }
        if let aKanji = json["kanji"].string {
            self.kanji = aKanji
        } else {
            self.kanji = ""
        }
        if let aVietnamese = json["vietnamese"].string {
            self.vietnamese = aVietnamese
        } else {
            self.vietnamese = ""
        }
        if let aFavorite = json["favourite"].bool {
            self.favourite = aFavorite
        } else {
            self.favourite = false
        }
        if let aVocabularyID = json["vocabularyID"].string {
            self.vocabularyID = aVocabularyID
        } else {
            self.vocabularyID = ""
        }
    }

}
