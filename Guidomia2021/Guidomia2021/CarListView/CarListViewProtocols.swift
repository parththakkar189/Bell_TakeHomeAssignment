//
//  CarListViewProtocols.swift
//  Guidomia2021
//
//  Created by Parth Thakkar on 2023-04-05.
//

import Foundation
import UIKit

protocol CarListViewPresenterToViewProtocol: AnyObject {
    func receivedCarListData()
}

protocol CarListViewViewToPresenterProtocol: AnyObject {
    var view: CarListViewPresenterToViewProtocol? { get set }
    var interactor: CarListViewPresenterToInteractorProtocol? { get set }
    var router: CarListViewPresenterToRouterProtocol? { get set }
    
    func callGetCarListData()
    func getCarListDataCount(isSearch: Bool) -> Int
    func getCarData(index: Int, isSearch: Bool) -> CarsList?
    func callGetFilteredData(carDetail: String, via: DataFilter)
    func getFilteredCarData(index: Int) -> CarsList?
    func getFilterdCarListDataCount() -> Int
}

protocol CarListViewPresenterToInteractorProtocol: AnyObject {
    var presenter: CarListViewInteractorToPresenterProtocol? { get set }
    var carsList: [CarsList] { get set }
    var filteredCarList: [CarsList] { get set }
    func getCarListData()
    func filterCarListData(inputString: String, via: DataFilter)
}

protocol CarListViewInteractorToPresenterProtocol: AnyObject {
    func presentCarListData()
}

protocol CarListViewPresenterToRouterProtocol: AnyObject {
    static func createModule() -> UINavigationController
}

enum DataFilter {
    case make
    case model
}
