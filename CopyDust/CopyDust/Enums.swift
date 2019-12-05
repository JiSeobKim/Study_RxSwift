//
//  Enums.swift
//  CopyDust
//
//  Created by kimjiseob on 2019/12/03.
//  Copyright © 2019 김지섭. All rights reserved.
//

import RxSwift
import RxCocoa

// 메인 하단 스크롤 정보 및 뷰
enum MoreWeatherInfos: String, CaseIterable {
    case pm10Value = "미세먼지"
    case pm25Value = "초미세먼지"
    case khaiGrade = "통합대기지수"
    case o3Grade = "오존"
    case coGrade = "일산화탄소"
    case no2Grade = "이산화질소"
    case so2Grade = "아황산가스"
    
    
    func getWeathInfoView(drive:SharedSequence<DriverSharingStrategy, StationWeatherInfo>, bag: DisposeBag) -> WeatherDetailInfoView {
        let view = WeatherDetailInfoView(title: self.rawValue, value: "100")
        
        // bind
        switch self {
        case .pm10Value:
            drive
            .map{$0.pm10Value}
            .drive(view.valueLabel.rx.text)
            .disposed(by: bag)
        case .pm25Value:
            drive
            .map{$0.pm25Value}
            .drive(view.valueLabel.rx.text)
            .disposed(by: bag)
        case .khaiGrade:
            drive
            .map{$0.khaiGrade}
            .drive(view.valueLabel.rx.text)
            .disposed(by: bag)
        case .o3Grade:
            drive
            .map{$0.o3Grade}
            .drive(view.valueLabel.rx.text)
            .disposed(by: bag)
        case .coGrade:
            drive
            .map{$0.coGrade}
            .drive(view.valueLabel.rx.text)
            .disposed(by: bag)
        case .no2Grade:
            drive
            .map{$0.no2Grade}
            .drive(view.valueLabel.rx.text)
            .disposed(by: bag)
        case .so2Grade:
            drive
            .map{$0.so2Grade}
            .drive(view.valueLabel.rx.text)
            .disposed(by: bag)
        }
        
        return view
    }
}


/// Si Type
enum SiType: String, CaseIterable {
    case daegu
    case daejeon
    case gangwon
    case gwangju
    case gyeongbuk
    case gyeonggi
    case gyeongnam
    case incheon
    case jeju
    case jeonbuk
    case jeonnam
    case sejong
    case seoul
    case ulsan
}

enum Testtt: CaseIterable {
    case no1
    case no2
    case no3
}

/// Weather Item Type
enum WeatherItemType: String {
    case SO2, CO, O3, NO2, PM10, PM25
}
