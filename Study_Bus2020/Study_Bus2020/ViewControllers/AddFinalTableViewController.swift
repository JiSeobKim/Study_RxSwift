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
        case findStation(routeInfo: (routeId: String, routeNm: String))
        case findBus(stationInfo: (stationId: String, stationNm: String))
    }
    
    var searchType: SearchType?
    
    private var selectedViewModel: AddBusDataSource?
    private var searchText: String?
    private var bag = DisposeBag()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        guard self.searchType != nil else { return }
        
        switch searchType! {
        case .findStation(let routeInfo):
            self.selectedViewModel = BusStationInfoByRouteIDViewModel()
            self.searchText = routeInfo.routeId
            self.title = "정류장 선택"
        case .findBus(let stationInfo):
            self.selectedViewModel = BusStationInfoByIDViewModel()
            
            self.title = "버스 선택"
            self.searchText = stationInfo.stationId
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
    
    private func save(routeId: String?, routeNm: String?, stationId: String?, stationNm: String?) {
        guard
            let routeId = routeId,
            let routeNm = routeNm,
            let stationId = stationId,
            let stationNm = stationNm
            else { return }
        
        do {
            try CoreDataClient.saveBusData(routeId: routeId, routeNm: routeNm, stationId: stationId, stationNm: stationNm)
            self.performSegue(withIdentifier: "goMain", sender: nil)
            print("Save Success")
        } catch {
            print("Save Error: \(error)")
        }
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
        case .findStation(let routeInfo):
            let item = self.selectedViewModel?.objectList[indexPath.row] as? BusStationInfoByRouteID
            let stationID = item?.stId
            
            self.save(routeId: routeInfo.routeId, routeNm: routeInfo.routeNm, stationId: stationID, stationNm: item?.stNm)
            break
        case .findBus(let stationInfo):
            let item = self.selectedViewModel?.objectList[indexPath.row] as? BusStationInfoByID
            let routeID = item?.busRouteId
            let routeNm = item?.busRouteNm
            
            self.save(routeId: routeID, routeNm: routeNm, stationId: stationInfo.stationId, stationNm: stationInfo.stationNm)
            break
        case .none:
            break
        }
    }
}
