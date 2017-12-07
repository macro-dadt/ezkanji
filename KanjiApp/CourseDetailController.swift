//
//  CourseDetailController.swift
//  KanjiApp
//
//  Created by DT Dat on 2017/08/15.
//  Copyright © 2017 DT Dat. All rights reserved.
//

import Foundation
import UIKit

class CourseDetailController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    
    var course:Course?{
        didSet{
            if course?.screenshots != nil {
                return
            }
            
            if let id = course?.id {
                let urlString = "http://www.statsallday.com/appstore/appdetail?id=\(id)"
                
                
                URLSession.shared.dataTask(with: URL(string: urlString)!, completionHandler: { (data, response, error) -> Void in
                    
                    if error != nil {
                        print(error!)
                        return
                    }
                    
                    do {
                        let json = try(JSONSerialization.jsonObject(with: data!, options: .mutableContainers))
                        
                        let courseDetail = Course()
                        courseDetail.setValuesForKeys(json as! [String: AnyObject])
                        self.course = courseDetail
                        DispatchQueue.main.async(execute: { () -> Void in
                            self.collectionView?.reloadData()
                        })
                    } catch let err {
                        print(err)
                    }
                }).resume()
            }
        }
    }
    private let headerId = "headerId"
    private let cellId = "cellId"
    private let descitpionCellId = "descriptonCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        collectionView?.alwaysBounceVertical = true
        collectionView?.backgroundColor = .white
        collectionView?.register(CourseDetailHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView?.register(ScreenshotsCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(CourseDetailDescriptionCell.self, forCellWithReuseIdentifier: descitpionCellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header  = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! CourseDetailHeader
        header.course = course
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.item == 1{
            let dummySize = CGSize(width: view.frame.width - 16, height: 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin)
            let rect = descriptionAttributedText().boundingRect(with: dummySize, options: options, context: nil)
            return CGSize(width: view.frame.width, height: rect.height + 30)
        }
        return Utility.shared.CGSizeMake(view.frame.width, 170)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: descitpionCellId, for: indexPath) as! CourseDetailDescriptionCell
            cell.textView.attributedText = descriptionAttributedText()
            print("haha",descriptionAttributedText().string)
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ScreenshotsCell
        cell.course = course
        return cell
    }
    
    private func descriptionAttributedText() ->  NSAttributedString{
        let attributedText = NSMutableAttributedString(string: "Description\n", attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 14)])
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 10
        let range = NSMakeRange(0, attributedText.string.count)
        attributedText.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: range)
        
        if let desc = course?.desc{
            attributedText.append(NSAttributedString(string: desc, attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 12), NSAttributedStringKey.foregroundColor:UIColor.darkGray]))
        }
        return attributedText
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 170)
    }
    
}
class CourseDetailDescriptionCell: BaseCell {
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.isEditable = false
        tv.isSelectable = false
        return tv
    }()
    
    let dividerLine : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        return view
    }()
    
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(textView)
        addSubview(dividerLine)
        
        addConstraintsWithFormat(format: "H:|-8-[v0]-8-|", views: textView)
        addConstraintsWithFormat(format: "H:|-14-[v0]|", views: dividerLine)
        addConstraintsWithFormat(format: "V:|-4-[v0]-4-[v1(1)]|", views: textView ,dividerLine)
    }
}
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
class BaseCell:UICollectionViewCell{
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        
    }
}
