//
//  AddFinalTableViewController.swift
//  Study_Bus2020
//
//  Created by 김지섭 on 2020/02/01.
//  Copyright © 2020 kimjiseob. All rights reserved.
//

import UIKit
import RxSwift
import CoreData

class AddFinalTableViewController: UITableViewController {
    
    enum SearchType {
        case findStation(routeID: String)
        case findBus(stationID: String)
    }
    
    var searchType: SearchType?
    
    private var selectedViewModel: AddBusDataSource?
    private var searchText: String?
    private var bag = DisposeBag()
    
    private var routeID: String?
    private var stationID: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        guard self.searchType != nil else { return }
        
        switch searchType! {
        case .findStation(let route):
            self.selectedViewModel = BusStationInfoByRouteIDViewModel()
            self.searchText = route
            self.title = "정류장 선택"
            self.routeID = route
        case .findBus(let station):
            self.selectedViewModel = BusStationInfoByIDViewModel()
            self.searchText = station
            self.title = "버스 선택"
            self.stationID = station
        }
        
        
        if searchText != nil {
            let completable = self.selectedViewModel?.searchData(text: searchText!)
            
            completable?
                .subscribeOn(MainScheduler.instance)
                .subscribe(onCompleted: {
                    self.tableView.reloadData()
                }, onError: { (e) in
                    print("error: \(e.localizedDescription)")
                }).disposed(by: bag)
        }
    }
    
    private func save(route: String?, station: String?) {
        guard
            let route = route,
            let station = station
            else { return }
        
        // TODO: Core Data 적용중
//        do {
//            try CoreDataClient.saveBusData(route: route, station: station)
//            print("Save Success")
//        } catch {
//            print("Save Error: \(error)")
//        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.selectedViewModel?.objectList.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = self.selectedViewModel?.objectList[indexPath.row] as? AddCellAvailable else {
            return UITableViewCell()
        }
        
        let cellId = item.addCellSubtitle == nil ? "BasicCell" : "SubtitleCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        cell.textLabel?.text = item.addCellTitle
        cell.detailTextLabel?.text = item.addCellSubtitle
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch self.searchType {
        case .findStation(let route):
            let item = self.selectedViewModel?.objectList[indexPath.row] as? BusStationInfoByRouteID
            let stationID = item?.stId
            
            self.save(route: route, station: stationID)
            break
        case .findBus(let station):
            let item = self.selectedViewModel?.objectList[indexPath.row] as? BusStationInfoByID
            let routeID = item?.busRouteId
            
            self.save(route: routeID, station: station)
            break
        case .none:
            break
        }
    }
}
