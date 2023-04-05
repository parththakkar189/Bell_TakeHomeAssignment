//
//  CarListEntity.swift
//  Guidomia2021
//
//  Created by Parth Thakkar on 2023-04-05.
//

import Foundation

struct CarsList: Decodable {
    let consList: [String]
    let customerPrice: Float
    let make: String
    let prosList: [String]
    let rating: UInt
    let carImage: String
    let model: String
    
    enum CodingKeys: String, CodingKey {
        case consList
        case customerPrice
        case make
        case prosList
        case rating
        case carImage
        case model
    }
}
