//
//  LargerCell.swift
//  KanjiApp
//
//  Created by DT Dat on 2017/08/15.
//  Copyright © 2017 DT Dat. All rights reserved.
//

import UIKit

class LargeCategoryCell: CategoryCell {
    
    private let largeAppCellId = "largeAppCellId"
    
    override func setupViews() {
        super.setupViews()
        coursesCollectionView.register(LargeAppCell.self, forCellWithReuseIdentifier: largeAppCellId)
    }
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return Utility.shared.CGSizeMake(200, frame.height-32)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: largeAppCellId, for: indexPath) as! CourseCell
        cell.course = courseCategory?.courses?[indexPath.item]
        return cell
    }
    fileprivate class LargeAppCell:CourseCell{
        fileprivate override func setupViews() {
            addSubview(imageView)
            addConstraintsWithFormat(format: "H:|[v0]|", views: imageView)
            addConstraintsWithFormat(format: "V:|-2-[v0]-14-|", views: imageView)
        }
    }
}
