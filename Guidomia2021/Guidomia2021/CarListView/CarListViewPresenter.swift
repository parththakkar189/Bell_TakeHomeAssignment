//
//  CarListViewPresenter.swift
//  Guidomia2021
//
//  Created by Parth Thakkar on 2023-04-05.
//

import Foundation

class CarListViewPresenter: CarListViewViewToPresenterProtocol {
    
     var view: CarListViewPresenterToViewProtocol?
     var interactor: CarListViewPresenterToInteractorProtocol?
     var router: CarListViewPresenterToRouterProtocol?

    func callGetCarListData() {
        interactor?.getCarListData()
    }
    
    func getCarData(index: Int, isSearch: Bool) -> CarsList? {
        if isSearch {
            guard let filteredCarDetail = interactor?.filteredCarList[index] else {
                return nil
            }
            return filteredCarDetail
        }
        guard let carDetail = interactor?.carsList[index] else {
                return nil
        }
        return carDetail
    }
    
    func getCarListDataCount(isSearch: Bool) -> Int {
        if isSearch {
            guard let filteredCount = interactor?.filteredCarList.count else {
                return 0
            }
            return filteredCount
        }
        guard let count = interactor?.carsList.count else {
            return 0
        }
        return count
    }
    
    func callGetFilteredData(carDetail: String, via: DataFilter) {
        interactor?.filterCarListData(inputString: carDetail, via: via)
    }
    
    func getFilterdCarListDataCount() -> Int {
        guard let count = interactor?.filteredCarList.count else {
            return 0
        }
        return count
    }
    
    func getFilteredCarData(index: Int) -> CarsList? {
        guard let carDetail = interactor?.filteredCarList[index] else {
            return nil
        }
        return carDetail
    }
}


extension CarListViewPresenter: CarListViewInteractorToPresenterProtocol {
    func presentCarListData() {
        view?.receivedCarListData()
    }
}
