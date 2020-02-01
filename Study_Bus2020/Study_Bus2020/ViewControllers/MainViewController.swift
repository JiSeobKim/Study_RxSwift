//
//  ViewController.swift
//  Study_Bus2020
//
//  Created by kimjiseob on 2020/01/18.
//  Copyright © 2020 kimjiseob. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            guard tableView != nil else { return }
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    var dataList: [BusData] = []
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let data = CoreDataClient.fetchBusDatas()
        
        self.dataList = data
        self.tableView.reloadData()
    }

    @IBAction func unwindToMain(_ unwindSegue: UIStoryboardSegue) {
    }
}


extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let busNoLabel = cell.contentView.viewWithTag(1) as? UILabel
        let stationNmLabel = cell.contentView.viewWithTag(2) as? UILabel
        
        let item = self.dataList[indexPath.row]
        stationNmLabel?.text = "(\(item.stationNm ?? ""))"
        busNoLabel?.text = item.routeNm
        
        return cell
    }
}
