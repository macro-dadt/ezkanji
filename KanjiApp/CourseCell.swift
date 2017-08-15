//
//  CourseCell.swift
//  KanjiApp
//
//  Created by DT Dat on 2017/08/15.
//  Copyright © 2017 DT Dat. All rights reserved.
//

import UIKit
class CourseCell:UICollectionViewCell{
    
    var course:Course?{
        didSet{
            
            
            if let name = course?.name {
                nameLabel.text = name
                
                let rect = NSString(string: name).boundingRect(with: CGSize(width: frame.width, height: 1000), options: NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin), attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)], context: nil)
                
                if rect.height > 20 {
                    categoryLabel.frame = CGRect(x: 0, y: frame.width + 38, width: frame.width, height: 20)
                    pricingLabel.frame = CGRect(x: 0, y: frame.width + 56, width: frame.width, height: 20)
                } else {
                    categoryLabel.frame = CGRect(x: 0, y: frame.width + 22, width: frame.width, height: 20)
                    pricingLabel.frame = CGRect(x: 0, y: frame.width + 40, width: frame.width, height: 20)
                }
                
                nameLabel.frame = CGRect(x: 0, y: frame.width + 5, width: frame.width, height: 40)
                nameLabel.sizeToFit()
                
            }
            categoryLabel.text = course?.category
            
            if let price = course?.price{
                pricingLabel.text = "$\(price)"
            }else{
                pricingLabel.text = ""
            }
            
            if let imagaName = course?.imageName{
                imageView.image = UIImage(named: imagaName)
            }
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let imageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "frozen")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 16
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let nameLabel : UILabel = {
        let label = UILabel()
        label.text = "Disney build it: Frozen"
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 2
        return label
    }()
    
    let categoryLabel : UILabel = {
        let label = UILabel()
        label.text = "Entertainment"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .darkGray
        return label
    }()
    
    let pricingLabel : UILabel = {
        let label = UILabel()
        label.text = "$3.99"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .darkGray
        return label
    }()
    
    func setupViews(){
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(categoryLabel)
        addSubview(pricingLabel)
        imageView.frame = Utility.shared.CGRectMake(0, 0, frame.width, 100)
        nameLabel.frame = Utility.shared.CGRectMake(0, frame.width+2, frame.width, 40)
        categoryLabel.frame = Utility.shared.CGRectMake(0, frame.width+38, frame.width, 20)
        pricingLabel.frame = Utility.shared.CGRectMake(0, frame.width+56, frame.width, 20)
        
    }
}
