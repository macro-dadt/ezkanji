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
        let layout = UICollectionViewFlowLayout()
        let featuredCoursesVC = FeaturedCoursesController(collectionViewLayout: layout)
        //let featuredCoursesVC = storyboard?.instantiateViewController(withIdentifier: "FeaturedCourses")
      
        self.addChildViewController(featuredCoursesVC)
        mainView.addSubview((featuredCoursesVC.view)!)

        // Do any additional setup after loading the view.
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
