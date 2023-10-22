//
//  Parser.swift
//  SmallworldTesr
//
//  Created by Aijaz Ali on 21/10/2023.
//

import Foundation
import SwiftyJSON

prefix operator <-

enum Parser {
    static func parse<T: Decodable>(type: T.Type, data: Data) -> T? {
        do {
            debugPrint(JSON(parseJSON: String(decoding: data, as: UTF8.self)))
            if type is BaseModel<PopularMoviesModel>.Type { // Define object type that you wanted to print
                debugPrint(JSON(parseJSON: String(decoding: data, as: UTF8.self)))
            }
            let decoder = JSONDecoder()
            #if DEBUG
            if data.statusCode == 200 { // Force try only if code is 200
                return try! decoder.decode(type.self, from: data) // swiftlint:disable:this force_try
            } else {
                return try decoder.decode(type.self, from: data)
            }
            #else
            return try decoder.decode(type.self, from: data)
            #endif
        } catch let parsingError {
            debugPrint(parsingError.localizedDescription)
            return nil
        }
    }
    
    static func parse<T: Decodable>(type: T.Type, data: [Any]) -> T? {
        do {
            if let firstItem = data.first {
                if firstItem is String { return nil }
                let jsonData = try JSONSerialization.data(withJSONObject: firstItem)
                #if DEBUG
                return try! JSONDecoder().decode(type.self, from: jsonData)// swiftlint:disable:this force_try
                #else
                return try JSONDecoder().decode(type.self, from: jsonData)
                #endif
            }
            return nil
        } catch _ {
            return nil
        }
    }
}
