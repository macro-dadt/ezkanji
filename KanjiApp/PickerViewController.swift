//
//  PickerViewController.swift
//  KanjiApp
//
//  Created by DT Dat on 2017/11/04.
//  Copyright © 2017 DT Dat. All rights reserved.
//

import UIKit
enum PickerType {
    case jlpt
}
class PickerViewController: UIViewController {
    @IBOutlet weak var picker: UIPickerView!
    var pickerType: PickerType = .jlpt
    var typeArr = ["Kanji", "Từ vựng"]
    var levelArr = ["N5", "N4", "N3", "N2", "N1"]
    var sourceArr = ["Mazzi","Mina","Somatoume","Mimikara"]
    var pageArr = ["1", "2", "3", "4", "5"]

    @IBAction func pushDone(_ sender: Any) {
          view.removeFromSuperview()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        picker.dataSource = self
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func updatePicker(pickerView: UIPickerView,component: Int,didSelectRow: Int)  {
        
    }
    func updateValue(component: Int,didSelectRow: Int)  {
        
    }
    
}
extension PickerViewController: UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 4
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerType == .jlpt {
            switch component {
            case 0:
                return typeArr.count
            case 1:
                return levelArr.count
            case 2:
                return sourceArr.count
            case 3 :
                return pageArr.count
            default:
                return 100
            }
        }
        return 100
        
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label = view as! UILabel!
        if label == nil {
            label = UILabel()
        }
        label?.textAlignment = .center
        label?.adjustsFontForContentSizeCategory = true
        label?.adjustsFontSizeToFitWidth = true
        if pickerType == .jlpt {
            switch component {
            case 0:
                label?.text = typeArr[row]
            case 1:
                label?.text = levelArr[row]
            case 2:
                label?.text = sourceArr[row]
            case 3:
                label?.text = pageArr[row]
            default:
                label?.text = nil
            }
        }
        return label!
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerType == .jlpt {
            pickerView.reloadAllComponents()
            updatePicker(pickerView: pickerView, component: component, didSelectRow: row)
            updateValue(component: component, didSelectRow: row)
            }
        }
    
    
}
