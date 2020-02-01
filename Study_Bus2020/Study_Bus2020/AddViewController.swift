//
//  AddViewController.swift
//  Study_Bus2020
//
//  Created by kimjiseob on 2020/01/18.
//  Copyright © 2020 kimjiseob. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class AddViewController: UIViewController {
    
    enum SelectedType: Int {
        case searcBusNum
        case searchStationID
        case searchStationNm
    }
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            guard tableView != nil else { return }
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var newSelectedViewModel: AddBusDataSource?
    
    private var bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindingItems()
    }
    
    var selectedType: SelectedType = .searcBusNum {
        didSet {
            switch selectedType {
            case .searcBusNum:
                self.newSelectedViewModel = BusInfoListByNumberViewModel()
            case .searchStationID:
                self.newSelectedViewModel = BusStationInfoByIDViewModel()
            case .searchStationNm:
                self.newSelectedViewModel = BusStopListViewModel()
            }
        }
    }
    
    private func bindingItems() {
        // 세그먼트 변경에 따른 처리
        self.segment.rx
            .selectedSegmentIndex
            .subscribe(onNext: { (index) in
                // 새 타입 셋팅
                if let newType = SelectedType(rawValue: index) {
                    self.selectedType = newType
                    self.searchBar.text = ""
                    self.tableView.reloadData()
                }
            }).disposed(by: bag)
        
        
        // Search Text 변화에 따른 검색 처리
        self.searchBar.rx
            .text
            .orEmpty
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: { (text) in
                if text != "" {
                    let complete = self.newSelectedViewModel?.searchData(text: text)
                    
                    complete?
                        .subscribeOn(MainScheduler.instance)
                        .subscribe(onCompleted: {
                            self.tableView.reloadData()
                        }, onError: { (e) in
                            print("Error: \(e)")
                            self.tableView.reloadData()
                        }).disposed(by: self.bag)
                }
            }).disposed(by: bag)
    }

}



extension AddViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newSelectedViewModel?.objectList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = self.newSelectedViewModel?.objectList[indexPath.row]
        
        switch self.selectedType {
        case .searcBusNum: // 버스 정보
            let realItem = item as? BusInfomation
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "SubtitleCell", for: indexPath)
            cell.textLabel?.text = realItem?.busRouteNm
            cell.detailTextLabel?.text = "출발지: \((realItem?.stStationNm) ?? "")"
            return cell
            
//        case is BusStationInfoByID:
//            let realItem = item as? BusStationInfoByID
//
//            let cell = tableView.dequeueReusableCell(withIdentifier: "SubtitleCell", for: indexPath)
//
//            cell.textLabel?.text = realItem?.busRouteNm
//
//            if let start = realItem?.stStationNm {
//                cell.detailTextLabel?.text = "출발지: \(start)"
//            }
//            return cell
            
        case .searchStationNm:
            let realItem = item as? BusStopListItem
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "SubtitleCell", for: indexPath)
            cell.textLabel?.text = realItem?.stNm
            cell.detailTextLabel?.text = "정류장 번호: \((realItem?.arsId) ?? "")"
            
            return cell
            
        default:
            return UITableViewCell()
        }
        
        
    }
}
