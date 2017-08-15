//
//  FeaturedCoursesViewController.swift
//  KanjiApp
//
//  Created by DT Dat on 2017/08/15.
//  Copyright © 2017 DT Dat. All rights reserved.
//

import UIKit

class FeaturedCoursesController: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    private let cellId = "cellId"
    private let largeCellId = "largeCellId"
    private let headerId = "headerId"
    var courseCategories : [CourseCategory]?
    var featuredCourses: FeaturedCourses?


    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationItem.title = "Featured Apps"
        CourseService.fetchFeaturedCourses{ (featuredCourses) -> () in
            self.featuredCourses = featuredCourses
            self.courseCategories = featuredCourses.courseCategories
            self.collectionView?.reloadData()
        }
        collectionView?.backgroundColor = .white
        collectionView?.register(CategoryCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(LargeCategoryCell.self, forCellWithReuseIdentifier: largeCellId)
        collectionView?.register(Header.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)

    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (indexPath.item == 2){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: largeCellId, for: indexPath) as! LargeCategoryCell
            cell.courseCategory = courseCategories?[indexPath.item]
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CategoryCell
        cell.courseCategory = courseCategories?[indexPath.item]
        cell.featuredCourseController = self
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = courseCategories?.count{
            return count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (indexPath.item == 2){
            return Utility.shared.CGSizeMake(view.frame.width, 160)
        }
        return Utility.shared.CGSizeMake(view.frame.width, 230)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return Utility.shared.CGSizeMake(view.frame.width, 120)
    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! Header
        header.courseCategory = featuredCourses?.bannerCategory
        return header
    }

    
    func showCourseDetail(course:Course){
        let layout = UICollectionViewFlowLayout()
        let courseDetailController = CourseDetailController(collectionViewLayout: layout)
        courseDetailController.course = course
        navigationController?.pushViewController(courseDetailController, animated: true)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
