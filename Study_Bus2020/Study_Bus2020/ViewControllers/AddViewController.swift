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
    
    private var selectedViewModel: AddBusDataSource?
    
    private var bag = DisposeBag()

    
    var selectedType: SelectedType = .searcBusNum {
        didSet {
            switch selectedType {
            case .searcBusNum:
                self.selectedViewModel = BusListByNumberViewModel()
                
            case .searchStationID:
                self.selectedViewModel = BusStationInfoByIDViewModel()
                
            case .searchStationNm:
                self.selectedViewModel = BusStationInfoByKeywordViewModel()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindingItems()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.destination {
        case is AddFinalTableViewController:
            
            let vc = segue.destination as! AddFinalTableViewController
            guard let item = sender as? (String,String) else { return }

            switch self.selectedType {
            case .searcBusNum:
                vc.searchType = .findStation(routeInfo: item)
                
            case .searchStationID:
                break
                
            case .searchStationNm:
                vc.searchType = .findBus(stationInfo: item)
                break
            }
            
        default:
            break
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
                    let complete = self.selectedViewModel?.searchData(text: text)
                    
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
        return selectedViewModel?.objectList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let item = self.selectedViewModel?.objectList[indexPath.row] as? AddCellAvailable else {
            return UITableViewCell()
        }
        
        
        let cellId = item.addCellSubtitle == nil ? "BasicCell" : "SubtitleCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        cell.textLabel?.text = item.addCellTitle
        cell.detailTextLabel?.text = item.addCellSubtitle
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var item: Any?
        
        switch self.selectedType {
        case .searcBusNum:
            let value = self.selectedViewModel?.objectList[indexPath.row] as! BusInfomation
            item = (value.busRouteId, value.busRouteNm)
        case .searchStationID:
            break
        case .searchStationNm:
            let value = self.selectedViewModel?.objectList[indexPath.row] as! BusStationInfoByKeyword
            item = (value.arsId, value.stNm)
            break
        }
        self.performSegue(withIdentifier: "ShowFinalStep", sender: item)
    }
}
