//
//  CarListViewController.swift
//  Guidomia2021
//
//  Created by Parth Thakkar on 2023-04-05.
//

import UIKit

class CarListViewController: UIViewController {

    //MARK: Outlers
    @IBOutlet weak var tblCarList: UITableView!
    @IBOutlet weak var txtModelFilter: UITextField!
    @IBOutlet weak var txtMakeFilter: UITextField!
    
    //MARK: Properties
    var presenter: CarListViewViewToPresenterProtocol?
    var expandedIndexPath: IndexPath? = IndexPath(row: 0, section: 0)
    var isSearch = false
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.presenter?.callGetCarListData()
        
        self.tblCarList.estimatedRowHeight = 125.0
        self.tblCarList.rowHeight = UITableView.automaticDimension
    }
}
//MARK: UITableview Delegate and Data Source Methods
extension CarListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter?.getCarListDataCount(isSearch: self.isSearch) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "carListViewTableViewCell") as! CarListViewTableViewCell
        if let item = self.presenter?.getCarData(index: indexPath.row,isSearch: self.isSearch) {
            if self.expandedIndexPath == indexPath {
                cell.configureCell(item: item, isExpanded: true)
            } else {
                cell.configureCell(item: item, isExpanded: false)
            }
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if expandedIndexPath == indexPath {
            return UITableView.automaticDimension
        }
        return 125.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        expandedIndexPath = indexPath
        tableView.beginUpdates()
        tableView.reloadRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
    }
}
//MARK: Implementation of PresenterToView Protocol
extension CarListViewController: CarListViewPresenterToViewProtocol {
    func receivedCarListData() {
        self.tblCarList.delegate = self
        self.tblCarList.dataSource = self
        DispatchQueue.main.async {
            self.tblCarList.reloadData()
        }
    }
}
//MARK: TextField Delegate Methods for Data Filter Purpose
extension CarListViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.txtMakeFilter {
            self.txtModelFilter.text = ""
        } else {
            self.txtMakeFilter.text = ""
        }
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.isEmpty {
            self.presenter?.callGetCarListData()
        }
        let currentText = textField.text! as NSString
        let updatedText = currentText.replacingCharacters(in: range, with: string)
        if textField == self.txtMakeFilter {
            self.presenter?.callGetFilteredData(carDetail: updatedText, via: .make)
        } else {
            self.presenter?.callGetFilteredData(carDetail: updatedText, via: .model)
        }
        
        if let count = self.presenter?.getFilterdCarListDataCount(), count > 0 {
            isSearch = true
        } else {
            isSearch = false
        }
        return true
    }
}
