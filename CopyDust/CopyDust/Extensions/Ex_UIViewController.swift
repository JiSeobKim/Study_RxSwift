//
//  Ex_UIViewController.swift
//  CopyDust
//
//  Created by kimjiseob on 2019/12/04.
//  Copyright © 2019 김지섭. All rights reserved.
//

import UIKit

extension UIViewController {
    func insertChildController(_ childController: UIViewController, intoParentView parentView: UIView) {
        childController.willMove(toParent: self)
        
        self.addChild(childController)
        childController.view.frame = parentView.bounds
        parentView.addSubview(childController.view)
        
        childController.didMove(toParent: self)
    }
}

