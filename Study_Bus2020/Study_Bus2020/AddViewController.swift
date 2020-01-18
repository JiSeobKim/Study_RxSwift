//
//  AddViewController.swift
//  Study_Bus2020
//
//  Created by kimjiseob on 2020/01/18.
//  Copyright © 2020 kimjiseob. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            guard tableView != nil else { return }
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}



extension AddViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        return cell
    }
}
