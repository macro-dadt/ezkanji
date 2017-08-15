//
//  CourseDetailHeader.swift
//  KanjiApp
//
//  Created by DT Dat on 2017/08/15.
//  Copyright © 2017 DT Dat. All rights reserved.
//

import UIKit

class CourseDetailHeader: BaseCell {
    
    var course:Course?{
        didSet{
            if let imageName = course?.imageName{
                imageView.image = UIImage(named: imageName)
            }
            nameLabel.text = course?.name
            if let price = course?.price?.stringValue{
                buyButton.setTitle("$\(price)", for: .normal)
            }
            else{
                buyButton.isHidden = true
            }
            
        }
    }
    
    let imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 16
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let segmentedControl : UISegmentedControl = {
        let sc = UISegmentedControl(items:["Details", "Reviews", "Related"])
        sc.tintColor = .darkGray
        sc.selectedSegmentIndex = 0
        return sc
    }()
    
    let nameLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let buyButton:UIButton = {
        let button = UIButton(type:.system)
        button.layer.borderColor = UIColor.returnRGBColor(r: 0, g: 129, b: 150, alpha: 1).cgColor
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        return button
    }()
    
    let dividerLine : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        return view
    }()
    
    override func setupViews() {
        super.setupViews()
        addSubview(imageView)
        addSubview(segmentedControl)
        addSubview(nameLabel)
        addSubview(buyButton)
        addSubview(dividerLine)
        
        addConstraintsWithFormat(format: "H:|-14-[v0(100)]-8-[v1]|", views: imageView, nameLabel)
        addConstraintsWithFormat(format: "V:|-14-[v0(100)]", views: imageView)
        addConstraintsWithFormat(format: "V:|-14-[v0(20)]", views: nameLabel)
        
        addConstraintsWithFormat(format: "H:|-40-[v0]-40-|", views: segmentedControl)
        addConstraintsWithFormat(format: "V:[v0(34)]-8-|", views: segmentedControl)
        addConstraintsWithFormat(format: "H:[v0(60)]-14-|", views: buyButton)
        addConstraintsWithFormat(format: "V:[v0(32)]-56-|", views: buyButton)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: dividerLine)
        addConstraintsWithFormat(format: "V:[v0(0.5)]|", views: dividerLine)
    }
}
