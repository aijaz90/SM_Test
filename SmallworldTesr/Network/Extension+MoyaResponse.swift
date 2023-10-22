//
//  Extension+MoyaResponse.swift
//  SmallworldTesr
//
//  Created by Aijaz Ali on 21/10/2023.
//

import Foundation
import Moya

extension Response {
    var message: String? {
        return self.data.message
    }
    
    var dict: [String: Any]? {
        return try? self.mapJSON(failsOnEmptyData: true) as? [String: Any] ?? [:]
    }
}
