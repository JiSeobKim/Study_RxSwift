//
//  SubViewController.swift
//  CopyDust
//
//  Created by kimjiseob on 2019/12/04.
//  Copyright © 2019 김지섭. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class SubViewController: UIViewController {

    @IBOutlet weak var segControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    private var items = BehaviorRelay<[(si: String, value: String?)]>(value: [])
    private var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTableView()
        self.setSeg()
    }
    
    private func setSeg() {
        let drive = self.segControl.rx.selectedSegmentIndex.asDriver()
        
        drive.drive(onNext: { (index) in
            guard
                let value = self.segControl.titleForSegment(at: index),
                let codeType = WeatherItemType.init(rawValue: value)
                else { return }
            
            self.getKoreaSiData(codeType: codeType)
            
        }).disposed(by: bag)
    }
    
    private func setTableView() {
        
        self.items.bind(to: self.tableView.rx.items(cellIdentifier: "cell", cellType: UITableViewCell.self)){ (raw, item, cell) in
            let siLabel = cell.contentView.viewWithTag(1) as? UILabel
            let valueLabel = cell.contentView.viewWithTag(2) as? UILabel
            
            siLabel?.text = item.si
            valueLabel?.text = item.value

        }.disposed(by: bag)
    }
    
    private func getKoreaSiData(codeType: WeatherItemType) {
        NetworkCollection.getKoreaSiWeetherInfo(itemCode: codeType) { (list) in
            guard let recentData = list?.first else { return }
            
            let convertedList = recentData.convertToList()
            self.items.accept(convertedList)
        }
    }
}
