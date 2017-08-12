//
//  KanjiService.swift
//  KanjiApp
//
//  Created by DT Dat on 2017/07/09.
//  Copyright © 2017 DT Dat. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift
import CoreSpotlight
open class KanjiService {
    
    let realm = try! Realm()
    lazy var vocabularyList : [Vocabulary] = {
    Array(self.realm.objects(Vocabulary))
    }()
    
    init() {
    self.vocabularyList = fetchVocabularyFromInitRealmDB()
    }
    
    func vocabularyWithID(_ vocabularyID: String) -> Kanji? {
    let filteredVocabularies = self.vocabularyList.filter {$0.vocabularyID == vocabularyID}
    return filteredVocabularies.first
    }
    func fetchVocabulary() -> [Vocabulary] {
    if vocabularyList.count > 0 {
    return vocabularyList
    }
    let dataFilePath: String? = Bundle.main.path(forResource: "Data", ofType: "json")
    guard dataFilePath != nil else {
    return [];
    }
    let jsonData = FileManager.default.contents(atPath: dataFilePath!)
    guard jsonData != nil else {
    return []
    }
    try! realm.write({
    let json = JSON(data: jsonData!)
    for (_, subJson):(String, JSON) in json {
    let vocabulary = Vocabulary(json: subJson)
    realm.add(vocabulary)
    }
    })
    vocabularyList = Array(realm.objects(Vocabulary))
    return vocabularyList
    }
    func fetchVocabularyFromInitRealmDB() -> [Vocabulary] {
    if vocabularyList.count > 0 {
    return vocabularyList
    }
    let dataFilePath = Bundle.main.path(forResource: "initialiseData", ofType: "realm")
    let defaultPath = realm.configuration.fileURL?.path
    guard defaultPath != nil &&  dataFilePath != nil else {
    return []
    }
    do {
    try FileManager.default.removeItem(atPath: defaultPath!)
    try FileManager.default.copyItem(atPath: dataFilePath!, toPath: defaultPath!)
    } catch {
    print(error)
    }
    return vocabularyList
    }
    }
extension VocabularyService {
    func indexAllVocabulary() {
        let searchableItems = self.vocabularyList.map { $0.searchableItem }
        CSSearchableIndex.default().indexSearchableItems(searchableItems) { error in
            if let error = error {
                print("Error = \(error)")
            }
        }
    }
    func destroyEmployeeIndexing() {
        CSSearchableIndex
            .default()
            .deleteAllSearchableItems { error in
                if let error = error {
                    print("Error deleting searching employee items: \(error)")
                } else {
                    print("Employees indexing deleted.")
                }
        }
    }
}

