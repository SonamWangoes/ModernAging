//
//  ArticleTableViewDataSource.swift
//  ModernAgingProject
//
//  Created by SONAM NARWARIYA on 15/01/24.
//

import Foundation
import UIKit

class ArticleTableViewDataSource <CELL : UITableViewCell,T> : NSObject,UITableViewDataSource{
    var cellIdentifier : String!
    var items : [T]!
    var configureCell : (CELL, T) -> () = {_,_ in }
    
    init(cellIdentifier : String, items : [T], configureCell : @escaping (CELL, T) -> ()) {
        self.cellIdentifier = cellIdentifier
        self.items =  items
        self.configureCell = configureCell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CELL
       let item = self.items[indexPath.row]
       self.configureCell(cell, item)
       return cell
    }
}
