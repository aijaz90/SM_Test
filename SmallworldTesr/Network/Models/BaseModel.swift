//
//  BaseModel.swift
//  SmallworldTesr
//
//  Created by Aijaz Ali on 21/10/2023.
//

import Foundation

class BaseModel<T: Codable>: Codable {
    
    let message: String?
    let status: Int?
    let data: T? // Generic Type to parse any type of data
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case status = "status"
        case data = "data"
    }
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        data = try values.decodeIfPresent(T.self, forKey: .data)
    }
    
}

class ListEntity <T: Codable>: Codable {
    // Define DynamicCodingKeys type needed for creating
    // decoding container from JSONDecoder
    private struct DynamicCodingKeys: CodingKey {
        // Compiler needs
        var intValue: Int?
        init?(intValue: Int) { return nil }
        
        // Use for string-keyed dictionary
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
    }
    
    var list: [T]
    var totalCount: Int
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: DynamicCodingKeys.self)
        let fullName = String(classNameAsString(T.self).split(separator: ".").first ?? "")
        
        list = try values.decodeIfPresent([T].self, forKey: DynamicCodingKeys(stringValue: "\(fullName.pluralize())")!) ?? [T]() // swiftlint:disable:this force_unwrapping
        debugPrint(try values.decodeIfPresent([T].self, forKey: DynamicCodingKeys(stringValue: "\(fullName.pluralize())")!) ?? [T]())
        
        totalCount = try values.decodeIfPresent(Int.self, forKey: DynamicCodingKeys(stringValue: "Total\(fullName.pluralize())")!) ?? Int() // swiftlint:disable:this force_unwrapping
    }
}

class SingleEntity <T: Codable>: Codable {
    // Define DynamicCodingKeys type needed for creating
    // decoding container from JSONDecoder
    private struct DynamicCodingKeys: CodingKey {
        // Compiler needs
        var intValue: Int?
        init?(intValue: Int) { return nil }
        
        // Use for string-keyed dictionary
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
    }
    
    var data: T?
    var message: String
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: DynamicCodingKeys.self)
        let fullName = String(classNameAsString(T.self).split(separator: ".").first ?? "")
        data = try values.decodeIfPresent(T.self, forKey: DynamicCodingKeys(stringValue: "\(fullName)")!) // swiftlint:disable:this force_unwrapping
        message = try values.decodeIfPresent(String.self,
                                             forKey: DynamicCodingKeys(stringValue: "Message")!) ?? String() // swiftlint:disable:this force_unwrapping
    }
}

func classNameAsString(_ obj: Any) -> String {
    // prints more readable results for dictionaries, arrays, Int, etc
    return String(describing: type(of: obj))
}
