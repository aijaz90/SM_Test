//
//  NSObject+Ext.swift
//  SmallworldTesr
//
//  Created by Aijaz Ali on 22/10/2023.
//

import Foundation

extension NSObject {
    static var nameOfClass: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}
