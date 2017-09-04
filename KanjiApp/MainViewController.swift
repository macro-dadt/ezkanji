//
//  MainViewController.swift
//  KanjiApp
//
//  Created by DT Dat on 2017/08/14.
//  Copyright © 2017 DT Dat. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var mainView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        removeTabbarItemsText(tabBar: (self.tabBarController?.tabBar)!)
        let layout = UICollectionViewFlowLayout()
        let featuredCoursesVC = FeaturedCoursesController(collectionViewLayout: layout)
        //let featuredCoursesVC = storyboard?.instantiateViewController(withIdentifier: "FeaturedCourses")
      featuredCoursesVC.view.frame = mainView.frame
        featuredCoursesVC.view.frame.origin.y = 0
        self.addChildViewController(featuredCoursesVC)
        mainView.addSubview((featuredCoursesVC.view)!)
        KanjiService.getKanjis(kanji: "亜", callback: {klist in
            for kanji in klist {
            print("kanji",kanji.kanji)
            }
        })
        
        //setup searchbar
        // Setup the Search Controller
    
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
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

