//
//  File.swift
//  Guidomia2021
//
//  Created by Parth Thakkar on 2023-04-05.
//

import Foundation
import UIKit

internal class Constants {
    static let shared = Constants()
    
    //MARK: Constants
    let carListViewController = "CarListViewController"
    
    
    
    
    //MARK: Methods
    static func loadStoryboard() -> UIStoryboard {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle(identifier: "com.parththakkar.Guidomia2021"))
        return storyBoard
    }
}

