//
//  CarListDataTests.swift
//  Guidomia2021Tests
//
//  Created by Parth Thakkar on 2023-04-05.
//
@testable import Guidomia2021
import XCTest

enum Errors: Error {
    case inCorrectFile
}

final class CarListDataTests: XCTestCase {

    /// Decodes a type from a bundle filename.
    func decode<T: Decodable>(_ type: T.Type, from filename: String) throws -> T {
        guard let json = Bundle.main.url(forResource: filename, withExtension: nil) else {
            throw Errors.inCorrectFile
        }

        let jsonData = try Data(contentsOf: json)
        let decoder = JSONDecoder()
        let result = try decoder.decode(T.self, from: jsonData)
        return result
    }
    
    func test_Decode_CarListData_FromFile() throws {
        _ = try? decode([CarsList].self, from: "car_list.json")
    }
    
    func test_Decode_CarListInvalid_FromFile() throws {
        let incorrectJson = try? decode([CarsList].self, from: "CarList_Invalid")
        XCTAssertNil(incorrectJson, "JSON Format inside the file is invalid.")
    }
}
