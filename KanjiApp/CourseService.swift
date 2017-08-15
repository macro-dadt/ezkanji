//
//  CourseService.swift
//  KanjiApp
//
//  Created by DT Dat on 2017/08/15.
//  Copyright © 2017 DT Dat. All rights reserved.
//

import Foundation
class CourseService: NSObject {
    
    class func fetchFeaturedCourses(completionHandler:@escaping (FeaturedCourses)->()){
        let urlString = "http://www.statsallday.com/appstore/featured"
        URLSession.shared.dataTask(with: URL(string:urlString)!) { (data, response, error) -> Void in
            if error != nil{
                print(error!)
                return
            }
            do{
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String:AnyObject]
                let featuredCourses = FeaturedCourses()
                print("result",json)
                featuredCourses.setValuesForKeys(json )
                DispatchQueue.main.async(execute: {
                    completionHandler(featuredCourses)
                })
                
                
            }catch let err{
                print(err)
            }
            
            }.resume()
    }
    
}
