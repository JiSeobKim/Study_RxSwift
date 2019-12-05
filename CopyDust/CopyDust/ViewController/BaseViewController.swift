//
//  BaseViewController.swift
//  CopyDust
//
//  Created by kimjiseob on 2019/12/04.
//  Copyright © 2019 김지섭. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    @IBOutlet weak var baseView1: UIView!
    @IBOutlet weak var baseView2: UIView!
    @IBOutlet weak var baseView1HeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var baseView2HeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    private var refreshControl = UIRefreshControl(frame: CGRect(x: 0, y: 0, width: 100, height: 100))

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setUI()
    }
    
    private func setUI() {
        // inner view - set radious
        for row in [baseView1, baseView2] {
            row?.layer.cornerRadius = 16
            row?.layer.masksToBounds = true
        }
        
        self.refreshControl.tintColor = .white
        self.refreshControl.addTarget(self, action: #selector(self.refreshAction), for: .valueChanged)
        scrollView.refreshControl = refreshControl
        // inner view  - safe area height
        self.view.layoutIfNeeded()
        let safeAreaHeight = self.view.safeAreaLayoutGuide.layoutFrame.height
        let safeAreaBottomInset = self.view.safeAreaInsets.top
        
        // inner view  - set height
        self.baseView1HeightConstraint.constant = safeAreaHeight - 40
        self.baseView2HeightConstraint.constant = safeAreaHeight - safeAreaBottomInset + 8
        
        // set VC
        guard
            let mainVC = self.storyboard?.instantiateViewController(identifier: "MainVC"),
            let subVC = self.storyboard?.instantiateViewController(identifier: "SubVC")
            else { return }
        
        self.insertChildController(mainVC, intoParentView: baseView1)
        self.insertChildController(subVC, intoParentView: baseView2)
        
        
    }
    
    
    @objc private func refreshAction() {
        self.refreshControl.endRefreshing()
    }
}
