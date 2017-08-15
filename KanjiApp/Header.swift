//
//  Header.swift
//  KanjiApp
//
//  Created by DT Dat on 2017/08/15.
//  Copyright © 2017 DT Dat. All rights reserved.
//

import UIKit

class Header: CategoryCell {
    private let bannerCellId = "bannerCellId"
    
    override func setupViews() {
        
        coursesCollectionView.delegate = self
        coursesCollectionView.dataSource = self
        coursesCollectionView.register(BannerCell.self, forCellWithReuseIdentifier: bannerCellId)
        addSubview(coursesCollectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: coursesCollectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: coursesCollectionView)
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return Utility.shared.CGSizeMake(frame.width/2 + 50, frame.height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: bannerCellId, for: indexPath) as! CourseCell
        cell.course = courseCategory?.courses?[indexPath.item]
        return cell
    }
    fileprivate class BannerCell:CourseCell{
        fileprivate override func setupViews() {
            addSubview(imageView)
            imageView.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
            imageView.layer.borderWidth = 0.5
            imageView.layer.cornerRadius = 0
            addConstraintsWithFormat(format: "H:|[v0]|", views: imageView)
            addConstraintsWithFormat(format: "V:|[v0]|", views: imageView)
        }
    }
    
}
