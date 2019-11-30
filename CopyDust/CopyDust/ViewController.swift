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

class ViewController: UIViewController {
    
    @IBOutlet weak var pm25Label: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var detailInfoStackView: UIStackView!
    
    
    private var weatherInfo = BehaviorRelay<WeatherInfo>(value: WeatherInfo.getDummyData())
    private var bag = DisposeBag()
    private var detailInfoList = [
        "미세먼지",
        "초미세먼지",
        "통합대기지수",
        "오존",
        "일산화탄소",
        "이산화질소",
        "아황산가스"
    ]
    
    
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
        
        // 이외에 정보들
        for row in self.detailInfoList {
            let view = WeatherDetailInfoView(title: row, value: "100")
            view.setSize()
            self.detailInfoStackView.addArrangedSubview(view)
            
            // bind
            switch row {
            case "미세먼지":
                drive
                    .map{$0.pm10Value}
                    .drive(view.valueLabel.rx.text)
                    .disposed(by: bag)
                break
            case "초미세먼지":
                drive
                    .map{$0.pm25Value}
                    .drive(view.valueLabel.rx.text)
                    .disposed(by: bag)
                break
            case "통합대기지수":
                drive
                    .map{$0.khaiGrade}
                    .drive(view.valueLabel.rx.text)
                    .disposed(by: bag)
                break
            case "오존":
                drive
                    .map{$0.o3Grade}
                    .drive(view.valueLabel.rx.text)
                    .disposed(by: bag)
                break
            case "일산화탄소":
                drive
                    .map{$0.coGrade}
                    .drive(view.valueLabel.rx.text)
                    .disposed(by: bag)
                break
            case "이산화질소":
                drive
                    .map{$0.no2Grade}
                    .drive(view.valueLabel.rx.text)
                    .disposed(by: bag)
                break
            case "아황산가스":
                drive
                    .map{$0.so2Grade}
                    .drive(view.valueLabel.rx.text)
                    .disposed(by: bag)
                break
            default:
                break
            }
        }
    }
    
    // Network
    private func getWeatherInfo() {
        let api = NetworkType.getList
        api.basicRequest { (dict) in
            guard
                let list = dict?["list"] as? [NSDictionary],
                let nowData = list.first
                else { return }
            
            let pm10Value = nowData["pm10Value"] as? String
            let pm25Value = nowData["pm25Value"] as? String
            let khaiGrade = nowData["khaiGrade"] as? String
            let o3Grade = nowData["o3Grade"] as? String
            let coGrade = nowData["coGrade"] as? String
            let dataTime = nowData["dataTime"] as? String
            let no2Grade = nowData["no2Grade"] as? String
            let so2Grade = nowData["so2Grade"] as? String
            
            let new = WeatherInfo(pm10Value: pm10Value,
                                  pm25Value: pm25Value,
                                  khaiGrade: khaiGrade,
                                  o3Grade: o3Grade,
                                  coGrade: coGrade,
                                  dataTime: dataTime,
                                  no2Grade: no2Grade,
                                  so2Grade: so2Grade)
            
            self.weatherInfo.accept(new)
        }
    }
}

