//
//  UIStoryBoard+Ext.swift
//  SmallworldTesr
//
//  Created by Aijaz Ali on 21/10/2023.
//

import UIKit

extension UIStoryboard {
    static var home: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
}

// MARK: Init VC from Storyboards with viewController static func instatiate
protocol Storyboarded {
    /// This function initialise the ViewController based on it's name from the storyboard you specify
    /// - Parameter storyboard: Pass the storyboard instance that conatins the viewController to be initialise
    static func instantiate(storyboard: UIStoryboard ) -> Self
    
    static func instantiate(withIdentifier identifier: String, storyboard: UIStoryboard ) -> Self
}



extension Storyboarded where Self: UIViewController {
    static func instantiate(storyboard: UIStoryboard) -> Self {
        // this pulls out "MyApp.MyViewController"
        let fullName = NSStringFromClass(self)
        
        // this splits by the dot and uses everything after, giving "MyViewController"
        let className = fullName.components(separatedBy: ".")
            .count > 1 ? fullName.components(separatedBy: ".")[1] : fullName
        
        // instantiate a view controller with that identifier, and force cast as the type that was requested
        return storyboard.instantiateViewController(withIdentifier: className) as? Self ?? Self()
    }
    
    static func instantiate(withIdentifier identifier: String, storyboard: UIStoryboard) -> Self {
        return storyboard.instantiateViewController(withIdentifier: identifier) as? Self ?? Self()
    }
}


