//
//  ViewController.swift
//  MVVM_2st_Exam2
//
//  Created by kimjiseob on 2019/12/27.
//  Copyright © 2019 JS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let dataSource = ["One", "Two", "Three"]
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    @IBAction func tapRightItlem(_ sender: UIBarButtonItem) {
        print("right button item tapped")
    }
    
}



extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        tableViewCell.textLabel?.text = self.dataSource[indexPath.row]
        tableViewCell.detailTextLabel?.text = self.dataSource[indexPath.row] + "subtitle"
        
        return tableViewCell
    }
}
