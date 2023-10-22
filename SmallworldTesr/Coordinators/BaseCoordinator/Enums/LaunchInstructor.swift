//
//  LaunchInstructor.swift
//  SmallworldTesr
//
//  Created by Aijaz Ali on 21/10/2023.
//

import Foundation

enum LaunchInstructor {

    case main
    case auth
    case onboarding

    // MARK: - Public methods
    static func configure(isAutorized: Bool = false, tutorialWasShown: Bool = false) -> LaunchInstructor {
       // let defaults = Defaults.shared
        let isAutorized = true //defaults.isUserLoggedIn
        let tutorialWasShown = true//defaults.tutorialWasShown
        switch (tutorialWasShown, isAutorized) {
        case (false, false): return .auth
        case (true, false), (true, true): return .main
        default: return .onboarding
        }
    }
}
