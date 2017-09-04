//
//  WordsViewController.swift
//  KanjiApp
//
//  Created by DT Dat on 2017/08/20.
//  Copyright © 2017 DT Dat. All rights reserved.
//

import UIKit

class WordsViewController: UITableViewController{
    var kanjis:[Kanji] = []
    var page = 1
    var limitPage = 50
    var hasNextPage = true
    let searchBar = UISearchBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        createSearchBar()
        removeTabbarItemsText(tabBar: (self.tabBarController?.tabBar)!)
        KanjiService.getKanjis(level: 5,callback: {kanjiList in
            self.kanjis = kanjiList
            print(kanjiList[1].kanji)
            self.tableView.reloadData()
        })
    }

    func createSearchBar() {
        searchBar.showsCancelButton = true
        searchBar.placeholder = "Search"
        searchBar.delegate = self
        self.navigationItem.titleView = searchBar
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return kanjis.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath)
        cell.textLabel?.text = kanjis[indexPath.row].kanji
        cell.detailTextLabel?.text = kanjis[indexPath.row].mean
    
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchBar.resignFirstResponder()
        showNextViewController(story: "Main", id: "WordDetail", obj: kanjis[indexPath.row])
    }
}
extension WordsViewController: UISearchBarDelegate{
    func updateSearchResults(for searchController: UISearchController) {
        // TODO
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("search",self.searchBar.text!)
        KanjiService.getKanjis(kanji: self.searchBar.text!.uppercased(), callback: {klist in
            self.kanjis = klist
            self.tableView.reloadData()
        })
    }
    
}
