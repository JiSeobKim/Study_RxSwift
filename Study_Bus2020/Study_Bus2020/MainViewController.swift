//
//  ViewController.swift
//  Study_Bus2020
//
//  Created by kimjiseob on 2020/01/18.
//  Copyright © 2020 kimjiseob. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let result = BusAPIClient.getBusStationInfoList(keyword: "상일여고")
        
        result.subscribe(onSuccess: { (list) in
            print("list")
        }) { (e) in
            print("list")
        }
    }


}


