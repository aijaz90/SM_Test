//
//  UIColor+Ext.swift
//  SmallworldTesr
//
//  Created by Aijaz Ali on 22/10/2023.
//

import UIKit

extension UIColor {

    // MARK: - sample colors to user
   
    public class var darkTextColor: UIColor {
        return UIColor(named: "textGray") ?? .white
    }
    
    public class var appBackgroundColor: UIColor {
        return UIColor(named: "BackgroundColor") ?? .white
    }
}
