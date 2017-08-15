//
//  FeaturedCourses.swift
//  KanjiApp
//
//  Created by DT Dat on 2017/08/15.
//  Copyright © 2017 DT Dat. All rights reserved.
//

import Foundation
class FeaturedCourses:NSObject{
    var bannerCategory:CourseCategory?
    var courseCategories:[CourseCategory]?
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "categories"{
            courseCategories = [CourseCategory]()
            for dict in value as! [[String:AnyObject]]{
                let courseCategory = CourseCategory()
                courseCategory.setValuesForKeys(dict)
                courseCategories?.append(courseCategory)
            }
        }
        else if key == "bannerCategory"{
            bannerCategory = CourseCategory()
            bannerCategory?.setValuesForKeys(value as! [String:AnyObject])
        }
        else{
            super.setValue(value, forKey: key)
        }
    }
}
