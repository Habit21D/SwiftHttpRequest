import Foundation
import UIKit
///当json数据某个值为空时，给予默认值
public extension KeyedDecodingContainer {

    func decode(_ type: Bool.Type, forKey key: KeyedDecodingContainer.Key) throws -> Bool {
        return try decodeIfPresent(type, forKey: key) ?? false
    }
    
    func decode(_ type: String.Type, forKey key: KeyedDecodingContainer.Key) throws -> String {
        return try decodeIfPresent(type, forKey: key) ?? ""
    }
    
    func decode(_ type: Double.Type, forKey key: KeyedDecodingContainer.Key) throws -> Double {
        return try decodeIfPresent(type, forKey: key) ?? 0.0
    }
    
    func decode(_ type: Float.Type, forKey key: KeyedDecodingContainer.Key) throws -> Float {
        return try decodeIfPresent(type, forKey: key) ?? 0.0
    }

    func decode(_ type: CGFloat.Type, forKey key: KeyedDecodingContainer.Key) throws -> CGFloat {
        return CGFloat(try decodeIfPresent(CGFloat.NativeType.self, forKey: key) ?? 0.0)
    }

    func decode(_ type: Int.Type, forKey key: KeyedDecodingContainer.Key) throws -> Int {
        return try decodeIfPresent(type, forKey: key) ?? 0
    }
    
    func decode(_ type: UInt.Type, forKey key: KeyedDecodingContainer.Key) throws -> UInt {
        return try decodeIfPresent(type, forKey: key) ?? 0
    }
    
    func decode<T>(_ type: T.Type, forKey key: KeyedDecodingContainer.Key) throws -> T where T: Decodable {
        
        if let value = try decodeIfPresent(type, forKey: key) {
            return value
        } else if let objectValue = try? JSONDecoder().decode(type, from: "{}".data(using: .utf8)!) {
            return objectValue
        } else if let arrayValue = try? JSONDecoder().decode(type, from: "[]".data(using: .utf8)!) {
            return arrayValue
        }
        let context = DecodingError.Context(codingPath: [key], debugDescription: "Key: <\(key.stringValue)> cannot be decoded")
        throw DecodingError.dataCorrupted(context)
    }
    
    func decodeIfPresent(_ type: Bool.Type, forKey key: K) throws -> Bool? {
        
        guard contains(key) else { return nil }
        
        let decoder = try superDecoder(forKey: key)
        let container = try decoder.singleValueContainer()
        if let value = try? container.decode(type) {
            return value
        } else if let intValue = try? container.decode(Int.self) {
            return intValue == 1
        } else if let doubleValue = try? container.decode(Double.self) {
            return doubleValue == 1
        } else if let stringValue = try? container.decode(String.self) {
            return stringValue == "1"
        }
        return nil
    }
    
    func decodeIfPresent(_ type: String.Type, forKey key: K) throws -> String? {
        
        guard contains(key) else { return nil }
        
        let decoder = try superDecoder(forKey: key)
        let container = try decoder.singleValueContainer()
        
        if let value = try? container.decode(type) {
            return value
        } else if let intValue = try? container.decode(Int.self) {
            return String(intValue)
        } else if let doubleValue = try? container.decode(Double.self) {
            return String(doubleValue)
        } else if let boolValue = try? container.decode(Bool.self) {
            return String(boolValue)
        }
        return nil
    }
    
    func decodeIfPresent(_ type: Double.Type, forKey key: K) throws -> Double? {
        
        guard contains(key) else { return nil }
        
        let decoder = try superDecoder(forKey: key)
        let container = try decoder.singleValueContainer()
        
        if let value = try? container.decode(type) {
            return value
        } else if let stringValue = try? container.decode(String.self) {
            return Double(stringValue)
        }
        return nil
    }
    func decodeIfPresent(_ type: Float.Type, forKey key: K) throws -> Float? {
        
        guard contains(key) else { return nil }
        
        let decoder = try superDecoder(forKey: key)
        let container = try decoder.singleValueContainer()
        
        if let value = try? container.decode(type) {
            return value
        } else if let stringValue = try? container.decode(String.self) {
            return Float(stringValue)
        }
        return nil
    }
    
    func decodeIfPresent(_ type: Int.Type, forKey key: K) throws -> Int? {
        guard contains(key) else { return nil }
        
        let decoder = try superDecoder(forKey: key)
        let container = try decoder.singleValueContainer()
        
        if let value = try? container.decode(type) {
            return value
        } else if let stringValue = try? container.decode(String.self) {
            return Int(stringValue)
        }
        return nil
    }
    
    func decodeIfPresent(_ type: UInt.Type, forKey key: K) throws -> UInt? {
        
        guard contains(key) else { return nil }
        
        let decoder = try superDecoder(forKey: key)
        let container = try decoder.singleValueContainer()
        
        if let value = try? container.decode(type) {
            return value
        } else if let stringValue = try? container.decode(String.self) {
            return UInt(stringValue)
        }
        return nil
    }
    
    func decodeIfPresent<T>(_ type: T.Type, forKey key: K) throws -> T? where T: Decodable {
        
        guard contains(key) else { return nil }
        
        let decoder = try superDecoder(forKey: key)
        let container = try decoder.singleValueContainer()
        return try? container.decode(type)
    }
}
