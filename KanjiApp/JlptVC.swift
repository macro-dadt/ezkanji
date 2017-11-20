//
//  JlptVC.swift
//  KanjiApp
//
//  Created by DT Dat on 2017/11/04.
//  Copyright © 2017 DT Dat. All rights reserved.
//

import UIKit

class JlptVC: UIViewController {
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
     var effectView: UIVisualEffectView?
    override func viewDidLoad() {
         button1.addTarget(self, action: #selector(makePickerView), for: .touchUpInside)
         button2.addTarget(self, action: #selector(makePickerView), for: .touchUpInside)
         button3.addTarget(self, action: #selector(showDatePicker), for: .touchUpInside)
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func showDatePicker() {
        
        if effectView == nil {
            effectView = UIVisualEffectView(effect: UIBlurEffect(style: .extraLight))
            effectView!.frame = CGRect(x: 0, y: view.frame.size.height - 216, width: view.frame.size.width, height: 216)
            
            let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 216))
            datePicker.datePickerMode = .date
            effectView!.contentView.addSubview(datePicker)
            
            let doneButton = UIButton(frame: CGRect(x: view.frame.size.width - 34 - 20, y: 10, width: 34, height: 30))
            
            doneButton.setTitle("OK", for: UIControlState())
            doneButton.setTitleColor(AppDelegate().blueColor, for: UIControlState())
            doneButton.addTarget(self, action: #selector(pushDoneButton), for: .touchUpInside)
            effectView!.contentView.addSubview(doneButton)
            view.addSubview(effectView!)
            
        }
    }
    func pushDoneButton() {
//        let datePicker = effectView!.contentView.subviews[0] as! UIDatePicker
//        var dateStr = datePicker.date.description
//        dateStr.replaceSubrange(dateStr.characters.index(dateStr.startIndex, offsetBy: 10)...dateStr.characters.index(dateStr.startIndex, offsetBy: 24), with: "")
//        dateStr = dateStr.replacingOccurrences(of: "-", with: "/")
//        let indexPath = IndexPath(row: 0, section: 0)
//        let cell = tableView.cellForRow(at: indexPath) as! ProfileEditTableViewCell
//        cell.pushedBirthdayButton.setTitle(dateStr, for: UIControlState())
//        cell.registerBirthDay(dateStr)
//        effectView!.removeFromSuperview()
//        effectView = nil
    }
    
    func makePickerView() {
            // ピッカーを表示
            let storyboard = UIStoryboard(name: "CustomView", bundle: nil)
            let pickerViewController = storyboard.instantiateViewController(withIdentifier: "Picker") as? PickerViewController
            addChildViewController(pickerViewController!)
            pickerViewController!.view.frame = CGRect(x: 0, y: view.frame.size.height - 216, width: view.frame.size.width, height: 216)
        pickerViewController!.pickerType = .jlpt
            view.addSubview(pickerViewController!.view)
        
        
    }

}
