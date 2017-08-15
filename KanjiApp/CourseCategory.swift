//
//  CourseCategory.swift
//  KanjiApp
//
//  Created by DT Dat on 2017/08/15.
//  Copyright © 2017 DT Dat. All rights reserved.
//

import Foundation
class CourseCategory: NSObject {
    var name:String?
    var courses: [Course]?
    var type:String?
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "apps"{
            courses = [Course]()
            for dict in value as! [[String:AnyObject]]{
                let course = Course()
                course.setValuesForKeys(dict)
                courses?.append(course)
            }
        }
        else{
            super.setValue(value, forKey: key)
        }
    }
    static func sampleCourseCategories() -> [CourseCategory]{
        
        let bestNewCoursesCategory = CourseCategory()
        bestNewCoursesCategory.name = "Best New Apps"
        
        var courses = [Course]()
        let frozenCourse = Course()
        frozenCourse.name = "Disney Build : Frozen"
        frozenCourse.imageName = "frozen"
        frozenCourse.category = "Entertainment"
        frozenCourse.price = NSNumber(value:3.99)
        courses.append(frozenCourse)
        bestNewCoursesCategory.courses = courses
        
        let bestNewGamesCategory = CourseCategory()
        bestNewGamesCategory.name = "Best New Games"
        
        var gamesApps = [Course]()
        let telepaintApp = Course()
        telepaintApp.name = "Telepaint"
        telepaintApp.imageName = "telepaint"
        telepaintApp.category = "Fantasy"
        telepaintApp.price = NSNumber(value:1.99)
        gamesApps.append(telepaintApp)
        bestNewGamesCategory.courses = gamesApps
        
        return [bestNewCoursesCategory, bestNewGamesCategory]
    }
}
