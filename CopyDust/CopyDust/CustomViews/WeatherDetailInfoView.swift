//
//  WeatherDetailInfoView.swift
//  CopyDust
//
//  Created by 김지섭 on 2019/11/30.
//  Copyright © 2019 김지섭. All rights reserved.
//

import UIKit
class WeatherDetailInfoView: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    convenience init(title: String, value: String) {
        self.init()
        self.common()
        
        self.titleLabel.text = title
        self.valueLabel.text = value
        self.setSize()
    }
    
    private func common() {
        let view = Bundle.main.loadNibNamed("WeatherDetailInfoView", owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        self.addSubview(view)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        
        // UI
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
    }
    
    func setSize() {
        self.layoutIfNeeded()
        let stackWidth = self.stackView.bounds.width + 24
        // 최소 폭 74
        let width = CGFloat.maximum(stackWidth, 74)
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
    }

}
