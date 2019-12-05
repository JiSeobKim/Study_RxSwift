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
    
    
    private var weatherInfo = BehaviorRelay<StationWeatherInfo>(value: StationWeatherInfo.getDummyData())
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
        
        
        NetworkCollection.getKoreaSiWeetherInfo(itemCode: .PM10) { (data) in
            guard let item = data?.first else { return }
            print(item)
        }
    }
    
    // Network
    private func getWeatherInfo() {
        NetworkCollection.getStationWeatherInfo { (object) in
            guard object != nil else { return }
            self.weatherInfo.accept(object!)
        }
    }
}

