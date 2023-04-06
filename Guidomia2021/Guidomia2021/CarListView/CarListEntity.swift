//
//  CarListEntity.swift
//  Guidomia2021
//
//  Created by Parth Thakkar on 2023-04-05.
//

import Foundation
import UIKit

struct CarsList: Decodable {
    var consList: [String]
    var customerPrice: Float
    var make: String
    var prosList: [String]
    var rating: UInt
    var model: String
    var marketPrice: Float
    enum CodingKeys: String, CodingKey {
        case consList
        case customerPrice
        case make
        case prosList
        case rating
        case model
        case marketPrice
    }
    
    func getCarImage() -> UIImage {
        switch CarImages(rawValue: make) {
        case .bmw:
            return CarImages.bmw.image
        case .mercedez:
            return CarImages.mercedez.image
        case .landRover:
            return CarImages.landRover.image
        case .alpine:
            return CarImages.alpine.image
        default:
            return UIImage()
        }
    }
}

enum CarImages: String {
    case alpine = "Alpine"
    case bmw = "BMW"
    case landRover = "Land Rover"
    case mercedez = "Mercedes Benz"
    
    public var image: UIImage {
        var imageName: String
        switch self {
        case .bmw:
            imageName = "BMW"
        case .alpine:
            imageName = "Alpine"
        case .landRover:
            imageName = "LandRover"
        case .mercedez:
            imageName = "Mercedez"
        }
        return UIImage(named: imageName)!
    }
}
