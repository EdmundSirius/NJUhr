//
//  TableViewController.swift
//  NJUhr
//
//  Created by apple on 2019/12/23.
//  Copyright © 2019 437.Inc. All rights reserved.
//

import Foundation
import UIKit

class TabViewController:UITableViewController{
    var sectionTitles = ["人事通知","人事新闻","公示公告","招聘信息"]
    var news:[String:[News]] = News.getNews()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension TabViewController{
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let newsKey = sectionTitles[section]
        guard let newsValue = news[newsKey]
            else {
                return 0
            }
        return newsValue.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
        let newsKey = sectionTitles[indexPath.section]
        if let newsValue = news[newsKey]{
            cell.new = newsValue[indexPath.item]
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails"{
            let detailViewController = segue.destination as! DetailViewController
            let indexPath = self.tableView.indexPathForSelectedRow!
            let section = indexPath.section
            let key = sectionTitles[section]
            let row = indexPath.row
            detailViewController.webSite = news[key]![row].path
        }
    }
}
