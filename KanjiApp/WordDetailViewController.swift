//
//  WordDetailViewController.swift
//  KanjiApp
//
//  Created by DT Dat on 2017/08/20.
//  Copyright © 2017 DT Dat. All rights reserved.
//

import UIKit
import SwiftSVG

class WordDetailViewController:DetailParentViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var subView2: UIView!
    @IBOutlet weak var kanjiImageView: UIImageView!
    
    @IBOutlet weak var storyTextView: UITextView!
  
    @IBOutlet weak var meanTxt: UILabel!
    @IBOutlet weak var kunTxt: UILabel!
    @IBOutlet weak var onTxt: UILabel!
    
    @IBOutlet weak var levelTxt: UILabel!
    
    var kanji:Kanji!
    

    override func viewDidLoad() {
        super.viewDidLoad()
            print("kanji1","start")
        scrollView.delegate = self
        kanji = data as! Kanji
      
        print("kanji1",kanji.kanji)
        setUpWord()


      
        
}
    func setUpWord() {
        self.title = kanji.kanji
        kanjiImageView.image = UIImage(named: "\(kanji.story_image).jpg")
        meanTxt.text = kanji.mean
        kunTxt.text = kanji.kunyomi
        onTxt.text = kanji.onyomi
        levelTxt.text = String(kanji.level)
        do {
            let attrStr = try NSAttributedString(
                data: kanji.story.data(using: String.Encoding.unicode, allowLossyConversion: true)!,
                options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
                documentAttributes: nil)
            storyTextView.attributedText = attrStr
        } catch let error {
            
        }
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
extension DetailParentViewController: UIScrollViewDelegate{

}
