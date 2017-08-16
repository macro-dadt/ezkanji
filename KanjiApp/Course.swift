//
//  Course.swift
//  KanjiApp
//
//  Created by DT Dat on 2017/08/15.
//  Copyright © 2017 DT Dat. All rights reserved.
//

import Foundation
class Course: NSObject {
    var id: NSNumber?
    var name: String?
    var category: String?
    var imageName: String?
    var price:NSNumber?
    var screenshots:[String]?
    var desc: String?
    var appInformation:AnyObject?
    //ko thay doi ten bien vi no dung de parse json
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "description"{
            self.desc = value as? String
        }
        else{
            super.setValue(value, forKey: key)
        }
    }
}

