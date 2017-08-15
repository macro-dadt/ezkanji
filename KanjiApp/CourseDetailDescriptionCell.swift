//
//  CourseDetailDescriptionCell.swift
//  KanjiApp
//
//  Created by DT Dat on 2017/08/15.
//  Copyright © 2017 DT Dat. All rights reserved.
//

import UIKit

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
