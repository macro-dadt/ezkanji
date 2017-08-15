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
                        print("respone",response ?? "nil")

                        let courseDetail = Course()
                        courseDetail.setValuesForKeys(json as! [String: AnyObject])
                        self.course = courseDetail
                         self.course?.desc = "dadgagdad"
                         print("urlString",courseDetail.screenshots ?? "nil cmnr")
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
        let attributedText = NSMutableAttributedString(string: "Description\n", attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 14)])
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 10
        let range = NSMakeRange(0, attributedText.string.characters.count)
        attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: range)
        
        if let desc = course?.desc{
            attributedText.append(NSAttributedString(string: desc, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 12), NSForegroundColorAttributeName:UIColor.darkGray]))
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
