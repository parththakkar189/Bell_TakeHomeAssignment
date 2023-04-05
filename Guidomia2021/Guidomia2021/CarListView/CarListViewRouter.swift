//
//  CarListViewRouter.swift
//  Guidomia2021
//
//  Created by Parth Thakkar on 2023-04-05.
//

import Foundation
import UIKit

class CarListViewRouter: CarListViewPresenterToRouterProtocol {
    static func createModule() -> UINavigationController {
        let view = Constants.loadStoryboard().instantiateViewController(withIdentifier: Constants.shared.carListViewController) as! CarListViewController
        let navigationController = UINavigationController(rootViewController: view)
        view.navigationController?.navigationBar.isHidden = true
        let presenter: CarListViewViewToPresenterProtocol & CarListViewInteractorToPresenterProtocol = CarListViewPresenter()
        let interactor: CarListViewPresenterToInteractorProtocol = CarListViewInteractor()
        let router: CarListViewPresenterToRouterProtocol = CarListViewRouter()
        view.presenter = presenter
        view.presenter?.interactor = interactor
        view.presenter?.router = router
        view.presenter?.view = view
        view.presenter?.interactor?.presenter = presenter
        return navigationController
    }
}
