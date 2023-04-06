//
//  MockCarListViewInteractor.swift
//  Guidomia2021Tests
//
//  Created by Parth Thakkar on 2023-04-05.
//

@testable import Guidomia2021
import Foundation

class MockCarListViewInteractor: CarListViewPresenterToInteractorProtocol {
    var presenter: CarListViewInteractorToPresenterProtocol?
    var carsList: [CarsList] = [CarsList]()
    var filteredCarList: [CarsList] = [CarsList]()
    
    func getCarListData() {
        self.carsList = [
            CarsList(consList: ["Con1", "Con2"], customerPrice: 80000.0, make: "Ford", prosList: ["Pro1","Pro2"], rating: 3, model: "Mustang"),
            CarsList(consList: ["Con1", "Con2","Con3","Con4"], customerPrice: 65000.0, make: "Dodge", prosList: ["Pro1","Pro2","Pro3"], rating: 5, model: "Charger"),
            CarsList(consList: ["Con1", "Con2","Con3"], customerPrice: 70000.0, make: "Chevy", prosList: ["Pro1","Pro2", "Pro3","Pro4"], rating: 2, model: "Impala")
        ]
        self.presenter?.presentCarListData()
    }
    
    func filterCarListData(inputString: String, via: DataFilter) {
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
    }
}


