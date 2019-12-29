//
//  VC-Extension+TableViewDataSource.swift
//  MVVM_2st_Exam2
//
//  Created by kimjiseob on 2019/12/27.
//  Copyright © 2019 JS. All rights reserved.
//

import Foundation
import UIKit

extension MVVMViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return messierViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        // #1 - The ViewModel is the app's de facto data source.
        tableViewCell?.imageView?.image = UIImage(named: messierViewModel[indexPath.row].thumbnail)
        tableViewCell?.textLabel?.text = messierViewModel[indexPath.row].formalName
        tableViewCell?.detailTextLabel?.text = messierViewModel[indexPath.row].commonName
        
        return tableViewCell!
    }
}
