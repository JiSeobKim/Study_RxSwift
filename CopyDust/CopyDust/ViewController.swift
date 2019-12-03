//
//  ViewController.swift
//  CopyDust
//
//  Created by 김지섭 on 2019/11/30.
//  Copyright © 2019 김지섭. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController {
    
    @IBOutlet weak var pm25Label: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var detailInfoStackView: UIStackView!
    
    
    private var weatherInfo = BehaviorRelay<WeatherInfo>(value: WeatherInfo.getDummyData())
    private var bag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setUI()
        self.getWeatherInfo()
    }
    
    
    private func setUI() {
        // remove temp view in stackView
        self.detailInfoStackView.subviews.forEach {$0.removeFromSuperview()}
        
        let drive = weatherInfo.asDriver()
        
        // 측정 날짜
        drive
            .map{$0.dataTime}
            .drive(self.dateLabel.rx.text)
            .disposed(by: bag)
        // 미세먼지 값
        drive
            .map{$0.pm25Value}
            .drive(self.pm25Label.rx.text)
            .disposed(by: bag)
        
        // 이외에 정보들 뷰 추가 적용
        for row in MoreWeatherInfos.allCases {
            let view = row.getWeathInfoView(drive: drive, bag: bag)
            self.detailInfoStackView.addArrangedSubview(view)
        }
    }
    
    // Network
    private func getWeatherInfo() {
        let api = NetworkType.getList
        api.basicRequest { (dict) in
            guard
                let list = dict?["list"] as? [Any],
                let nowData = list.first,
                let jsonData = try? JSONSerialization.data(withJSONObject: nowData, options: .prettyPrinted)
                else { return }

            // Use Codable
            guard let object = try? JSONDecoder().decode(WeatherInfo.self, from: jsonData) else { return }
            
            self.weatherInfo.accept(object)
        }
    }
}

