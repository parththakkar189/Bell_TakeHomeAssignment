//
//  CarListViewInteractor.swift
//  Guidomia2021
//
//  Created by Parth Thakkar on 2023-04-05.
//

import Foundation
import CoreData

class CarListViewInteractor: CarListViewPresenterToInteractorProtocol {
    var presenter: CarListViewInteractorToPresenterProtocol?
    var carsList: [CarsList] = [CarsList]()
    var filteredCarList: [CarsList] = [CarsList]()
    
    func getCarListData() {
        do {
            if let bundlePath = Bundle.main.path(forResource: "car_list", ofType: "json"), let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                self.carsList = try JSONDecoder().decode([CarsList].self, from: jsonData)
                DBManager.manager.prepare(dataForSaving: self.carsList)
                self.presenter?.presentCarListData()
            }
        } catch {
            print(error)
        }
    }
    
    func filterCarListData(inputString: String, via: DataFilter) {
        if self.carsList.count > 0 {
            switch via {
            case .model:
                self.filteredCarList = self.carsList.filter { item in
                    return item.model.lowercased().contains(inputString.lowercased())
                }
            case .make:
                self.filteredCarList = self.carsList.filter { item in
                    return item.make.lowercased().contains(inputString.lowercased())
                }
            }
            self.presenter?.presentCarListData()
        }
    }
}
