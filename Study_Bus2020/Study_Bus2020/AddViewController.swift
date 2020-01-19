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
    private var bag = DisposeBag()
    private var viewModelBag = DisposeBag()
    private var stationListViewModel = BusStopListViewModel()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.segment.rx
            .selectedSegmentIndex
            .subscribe(onNext: { (index) in
                
                self.viewModelBag = DisposeBag()
                
                switch index {
                case 0:
                    break
                case 1:
                    break
                case 2:
                    self.selectedViewModel = self.stationListViewModel
                    break
                default:
                    break
                }
                
            }).disposed(by: bag)
        
        let searchDriver = self.searchBar.rx.text.orEmpty.asDriver()
        
        
        searchDriver
            .debounce(.milliseconds(500))
            .drive(onNext: { (text) in
                self.selectedViewModel?.searchData(text: text)
            }).disposed(by: bag)
    }

}



extension AddViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedViewModel?.objectList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        
        
        let item = self.selectedViewModel?.objectList[indexPath.row]
        
        var text: String?
        
        switch item {
        case is BusStopListItem:
            let realItem = item as? BusStopListItem
            text = realItem?.stNm
        default:
            break
        }
        
        cell.textLabel?.text = text
        return cell
    }
}
