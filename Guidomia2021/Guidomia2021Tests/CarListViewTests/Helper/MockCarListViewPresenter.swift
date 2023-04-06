//
//  MockCarListViewPresenter.swift
//  Guidomia2021Tests
//
//  Created by Parth Thakkar on 2023-04-05.
//
@testable import Guidomia2021
import Foundation

class MockCarListPresenter: CarListViewViewToPresenterProtocol {

    var view: CarListViewPresenterToViewProtocol?
    var interactor: CarListViewPresenterToInteractorProtocol?
    var router: CarListViewPresenterToRouterProtocol?
    
    func callGetCarListData() {
        interactor?.getCarListData()
    }
    
    func callGetFilteredData(carDetail: String, via: DataFilter) {
        interactor?.filterCarListData(inputString: carDetail, via: via)
    }
    
    func getFilteredCarData(index: Int) -> CarsList? {
        guard let carDetail = interactor?.filteredCarList[index] else {
            return nil
        }
        return carDetail
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
    
    func getFilterdCarListDataCount() -> Int {
        guard let count = interactor?.filteredCarList.count else {
            return 0
        }
        return count
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
}

extension MockCarListPresenter: CarListViewInteractorToPresenterProtocol {
    func presentCarListData() {
        view?.receivedCarListData()
    }
}
