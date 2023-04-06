//
//  CarListViewPresenterTests.swift
//  Guidomia2021Tests
//
//  Created by Parth Thakkar on 2023-04-05.
//
@testable import Guidomia2021

import XCTest

final class CarListViewPresenterTests: XCTestCase {
    var presenter: MockCarListPresenter!
    
    override func setUp() {
        super.setUp()
        self.presenter = MockCarListPresenter()
        self.presenter.interactor = MockCarListViewInteractor()
        self.presenter.view = CarListViewController()
    }

    override func tearDown() {
        self.presenter.interactor = nil
        self.presenter = nil
        super.tearDown()
    }
 
    // func getCarListDataCount(isSearch: Bool) -> Int
//    func getCarData(index: Int, isSearch: Bool) -> CarsList?
//    func callGetFilteredData(carDetail: String, via: DataFilter)
//    func getFilteredCarData(index: Int) -> CarsList?
//    func getFilterdCarListDataCount() -> Int
    func test_Get_Car_ListData_Returns_Data() {
        presenter.callGetCarListData()
        XCTAssert(presenter.interactor!.carsList.count > 0, "CarList Array Contains Data")
    }
    
    func test_Get_Filtered_Car_ListData_Via_Make_Returns_Data() {
        presenter.callGetCarListData()
        presenter.callGetFilteredData(carDetail: "Ford", via: .make)
        XCTAssertTrue(presenter.interactor!.filteredCarList.count > 0, "Filtered Array Contains Data")
        XCTAssert(presenter.interactor!.filteredCarList.first?.rating == 3, "Filtered item rating")
        XCTAssert(presenter.interactor!.filteredCarList.first?.prosList.count == 2, "Filtered item pro")
    }
    
    func test_Get_Filtered_Car_ListData_Via_Model_Returns_Data() {
        presenter.callGetCarListData()
        presenter.callGetFilteredData(carDetail: "Impala", via: .model)
        XCTAssertTrue(presenter.getFilterdCarListDataCount() > 0, "Filtered Array Contains Data")
        XCTAssert(presenter.interactor!.filteredCarList.first?.rating == 2, "Filtered item rating")
        XCTAssert(presenter.interactor!.filteredCarList.first?.prosList.count == 4, "Filtered item pro")
    }
    
    func test_Get_Filtered_Car_ListData_Via_Model_Returns_No_Data() {
        presenter.callGetCarListData()
        presenter.callGetFilteredData(carDetail: "Malibu", via: .model)
        XCTAssert(presenter.getFilterdCarListDataCount() == 0, "Filtered Array Contains No Data")
    }
    
    func test_Get_Filtered_Car_ListData_Via_Make_Returns_No_Data() {
        presenter.callGetCarListData()
        presenter.callGetFilteredData(carDetail: "Hyundai", via: .make)
        XCTAssert(presenter.getFilterdCarListDataCount() == 0, "Filtered Array Contains No Data")
    }
    
    func test_Get_CarData_FromIndex_WithOutSearch() {
        presenter.callGetCarListData()
        let carDetail = presenter.getCarData(index: 2, isSearch: false)
        XCTAssert(carDetail!.consList.count == 3, "Item Cons List")
        XCTAssertFalse(carDetail!.rating == 3, "Item Rating Does not match")
    }
}

