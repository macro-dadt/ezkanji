//
//  CategoryCell.swift
//  KanjiApp
//
//  Created by DT Dat on 2017/08/15.
//  Copyright © 2017 DT Dat. All rights reserved.

import UIKit

class CategoryCell:UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    var featuredCourseController:FeaturedCoursesController?
    var courseCategory:CourseCategory?{
        didSet{
            if let name = courseCategory?.name{
                nameLabel.text = name
            }
            coursesCollectionView.reloadData()
        }
    }
    
    private let cellId = "appCellId"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let coursesCollectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    let dividerLineView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        return view
    }()
    
    let nameLabel : UILabel = {
        let label = UILabel()
        label.text = "Best Apps"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    func setupViews(){
        backgroundColor = .clear
        addSubview(coursesCollectionView)
        addSubview(dividerLineView)
        addSubview(nameLabel)
        coursesCollectionView.delegate = self
        coursesCollectionView.dataSource = self
        
        coursesCollectionView.register(CourseCell.self, forCellWithReuseIdentifier: cellId)
        addConstraintsWithFormat(format: "H:|[v0]|", views: coursesCollectionView)
        addConstraintsWithFormat(format: "H:|-14-[v0]|", views: dividerLineView)
        addConstraintsWithFormat(format: "H:|-14-[v0]|", views: nameLabel)
        addConstraintsWithFormat(format: "V:|[v0(30)][v1][v2(0.5)]|", views: nameLabel, coursesCollectionView, dividerLineView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = courseCategory?.courses?.count{
            return count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CourseCell
        cell.course = courseCategory?.courses?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return Utility.shared.CGSizeMake(100, frame.height-32)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 14, 0, 14)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let course = courseCategory?.courses?[indexPath.item]{
            featuredCourseController?.showCourseDetail(course:course )
        }
    }
    
}

