//
//  UIView+Ext.swift
//  SmallworldTesr
//
//  Created by Aijaz Ali on 22/10/2023.
//

import UIKit

extension UIView {
    
    class func fromNib<T: UIView>() -> T {
        return Bundle(for: T.self)
            .loadNibNamed(String(describing: T.self),
                          owner: nil,
                          options: nil)![0] as! T // swiftlint:disable:this force_cast force_unwrapping
    }
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            let color = UIColor(cgColor: layer.borderColor!)// swiftlint:disable:this force_unwrapping
            return color
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}
