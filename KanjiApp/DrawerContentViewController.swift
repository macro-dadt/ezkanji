//
//  DrawerPreviewContentViewController.swift
//  Pulley
//
//  Created by Brendan Lee on 7/6/16.
//  Copyright © 2016 52inc. All rights reserved.
//

import UIKit
class DrawerContentViewController: UIViewController {
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    @IBOutlet weak var arrowImage: UIImageView!
    
    @IBOutlet weak var contentScrollView: UIView!
    
   
    
    @IBOutlet var seperatorHeightConstraint: NSLayoutConstraint!
    static var drawer: PulleyViewController!
    static var delegate: DrawerContentViewController!
    
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DrawerContentViewController.delegate = self
        // Do any additional setup after loading the view.
        arrowImage.layer.cornerRadius = 2.5
        seperatorHeightConstraint.constant = 1.0 / UIScreen.main.scale
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension DrawerContentViewController: PulleyDrawerViewControllerDelegate {
    
    func collapsedDrawerHeight() -> CGFloat
    {
        return 100.0
    }
    
    func partialRevealDrawerHeight() -> CGFloat
    {
        return 270.0
    }
    
    func supportedDrawerPositions() -> [PulleyPosition] {
        return PulleyPosition.all // You can specify the drawer positions you support. This is the same as: [.open, .partiallyRevealed, .collapsed, .closed]
    }
    
    func drawerPositionDidChange(drawer: PulleyViewController)
    {
        DrawerContentViewController.drawer = drawer
        //tableView.isScrollEnabled = drawer.drawerPosition == .open
        switch drawer.drawerPosition {
        case .collapsed:
            arrowImage.image = UIImage(named:"arrow-up")
            break
        case .partiallyRevealed:
                       break
        case .open:
            arrowImage.image = UIImage(named:"arrow-down")
            break
        default:
            print("position", "other")
        }
        
    }
   
   
    func moveToCollapsed(){
        if let drawerVC = self.parent as? PulleyViewController
        {
            drawerVC.setDrawerPosition(position: .collapsed)
        }
        
    }
    func moveToPartiallyRevealed(){
        if let drawerVC = self.parent as? PulleyViewController
        {
            drawerVC.setDrawerPosition(position: .partiallyRevealed)
        }
        
    }
    
    func removeSearch(willRemove: Bool) {
        if willRemove {
                       topViewHeight.constant = 25.0
        }
        else{
           
            topViewHeight.constant = 68.0
        }
    }
    
    func removeAllsubviews() {
        for view in contentScrollView.subviews{
            view.removeFromSuperview()
        }
    }
    func hasSubviews() -> Bool {
        if contentScrollView.subviews.count > 0
        {
            return true
        }
        return false
        
        
    }
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        //        removeAllsubviews()
        //        searchBar.text = ""
        //        placeListViewController?.placeListType = .main
        //        self.addChildViewController(placeListViewController!)
        //        //        tableView = (placeListViewController?.tableView)! as! UITableView
        //        self.contentScrollView.addSubview((placeListViewController?.view)!)
        //
        
        return true
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
}

extension DrawerContentViewController: UISearchBarDelegate {
    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        }
    
}

extension DrawerContentViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "SampleCell", for: indexPath)
    }
}

extension DrawerContentViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 81.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let drawer = self.parent as? PulleyViewController
        {
            let primaryContent = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PrimaryTransitionTargetViewController")
            
            drawer.setDrawerPosition(position: .collapsed, animated: true)
            
            drawer.setPrimaryContentViewController(controller: primaryContent, animated: false)
        }
    }
}


