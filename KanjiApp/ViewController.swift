//
//  ViewController.swift
//  KanjiApp
//
//  Created by DT Dat on 2017/07/09.
//  Copyright © 2017 DT Dat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var filePaths = [String]() // Array of file paths to each CSV file to include
        let destinationRealmPath = "" // Path to the folder that will hold this Realm file
        
        // Analyze the files and produce a Realm-compatible schema
        let generator =  ImportSchemaGenerator(files: filePaths)
        let schema = try! generator.generate()
        
        // Use the schema and files to create the Realm file, and import the data
        let dataImporter = CSVDataImporter(files: filePaths)
        try! dataImporter.import(toPath: destinationRealmPath, schema: schema)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

