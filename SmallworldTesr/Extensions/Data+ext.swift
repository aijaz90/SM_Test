//
//  Data+ext.swift
//  SmallworldTesr
//
//  Created by Aijaz Ali on 21/10/2023.
//

import Foundation
import SwiftyJSON

extension Data {
    var message: String { return JSON(self)["Message"].string ?? "Something went wrong" }
    var statusCode: Int { return JSON(self)["Status"].int ?? 502 }
}
