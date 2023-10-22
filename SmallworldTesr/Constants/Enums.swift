//
//  Enums.swift
//  SmallworldTesr
//
//  Created by Aijaz Ali on 21/10/2023.
//

import Foundation

enum MoviesFetchDirection {
    case ascending
    case descending
    case none
    var descriptionValue: String {
        switch self {
            case .ascending:
                return "title.asc"
            case .descending:
                return "title.desc"
            default:
                return ""
        }
    }
}
