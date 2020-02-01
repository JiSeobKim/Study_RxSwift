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
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            guard tableView != nil else { return }
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    private var selectedViewModel: BusDataSource? {
        didSet {
            
            self.selectedViewModel?.isChanged.subscribe(onNext: { (isChanged) in
                if isChanged {
                    self.tableView.reloadData()
                }
            }).disposed(by: viewModelBag)
        }
    }
    private var newSelectedViewModel: AddBusDataSource?
    
    private var bag = DisposeBag()
    private var viewModelBag = DisposeBag()
    //0
    private var busInfoListViewModel = BusInfoListByNumberViewModel()
    //1
    //2
    private var stationListViewModel = BusStopListViewModel()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.segment.rx
            .selectedSegmentIndex
            .subscribe(onNext: { (index) in
                
                self.viewModelBag = DisposeBag()
                
                switch index {
                case 0:
//                    self.selectedViewModel = self.busInfoListViewModel
                    break
                case 1:
                    break
                case 2:
                    self.newSelectedViewModel = self.stationListViewModel
                    break
                default:
                    break
                }
                
            }).disposed(by: bag)
        
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
        
        var text: String?
        
        switch item {
        case is BusInfomation:
            let realItem = item as? BusInfomation
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "BusInfoCell", for: indexPath)
            
            cell.textLabel?.text = realItem?.busRouteNm
            
            if let start = realItem?.stStationNm {
                cell.detailTextLabel?.text = "출발지: \(start)"
            }
            
            
            return cell
            
        case is BusStopListItem:
            let realItem = item as? BusStopListItem
            text = realItem?.stNm
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "BusStopCell", for: indexPath)
            cell.textLabel?.text = text
            
            return cell
            
        default:
            return UITableViewCell()
        }
        
        
    }
}
