//
//  NSStringTransformer.swift
//  Guidomia2021
//
//  Created by Parth Thakkar on 2023-04-05.
//

import Foundation

class NSStringTransformer: ValueTransformer {
    
    override public class func transformedValueClass() -> AnyClass {
        return NSString.self
    }

    override public class func allowsReverseTransformation() -> Bool {
        return true
    }
    
    override func transformedValue(_ value: Any?) -> Any? {
        guard let str = value else {return nil }
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: str, requiringSecureCoding: true)
            return data
        } catch {
            return nil
        }
    }
    
    override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value else { return nil }
        do {
            let str = try NSKeyedUnarchiver.unarchivedObject(ofClass: NSString.self, from: data as! Data)
            return str
        } catch {
            return nil
        }
    }
}

extension NSStringTransformer {
    /// The name of the transformer. This is the name used to register the transformer using `ValueTransformer.setValueTrandformer(_"forName:)`.
    static let name = NSValueTransformerName(rawValue: String(describing: NSStringTransformer.self))

    /// Registers the value transformer with `ValueTransformer`.
    public static func register() {
        let transformer = NSStringTransformer()
        ValueTransformer.setValueTransformer(transformer, forName: name)
    }
}
