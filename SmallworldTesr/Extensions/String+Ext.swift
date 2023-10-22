//
//  String+Ext.swift
//  SmallworldTesr
//
//  Created by Aijaz Ali on 21/10/2023.
//

import Foundation

extension String {
    
    static func / (lhs: String, rhs: String) -> String {
        return lhs + "/" + rhs
    }
    
    /// Initializes an NSURL object with a provided URL string. (read-only)
    var url: URL {
        return URL(string: self)!
    }
    
    public func pluralize(count: Int = 2, with: String = "") -> String {
        guard !(count == 1) else { return self }
        guard with.length != 0 else { return Pluralize.apply(word: self) }
        return with
    }
    // Workaround to allow us to use `count` as an argument name in pluralize() above.
    private var length: Int {
        return self.count
    }
}
