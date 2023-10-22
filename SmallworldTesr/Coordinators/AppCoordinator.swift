//
//  AppCoordinator.swift
//  SmallworldTesr
//
//  Created by Aijaz Ali on 21/10/2023.
//

import UIKit

class AppCoordinator: BaseCoordinator {
    
    private let routerProtocol: RouterProtocol
    private var launchInstructor: LaunchInstructor
    
    init(router: RouterProtocol, launchInstructor: LaunchInstructor) {
        self.routerProtocol = router
        // let defaults = Defaults.shared
        self.launchInstructor = LaunchInstructor.configure(isAutorized: true,
                                                           tutorialWasShown: true)
    }
    
    override func start(with option: DeepLinkOption?) {
        if !self.childCoordinators.isEmpty {
            self.childCoordinators.forEach {
                $0.start(with: option)
            }
            return
        }
        switch launchInstructor { // Based on User session go to relevant flow
        case .auth:
            runAuthFlow()
        case .main:
            runAuthFlow()
        case .onboarding:
            runAuthFlow()
        }
    }
    
    func runAuthFlow() {
        if let coordinator = AppDelegate.container.resolve(MainCoordinator.self) {
            coordinator.finishFlow = {[unowned self, unowned coordinator] in
                self.removeDependency(coordinator)
                
                self.launchInstructor = LaunchInstructor.configure(isAutorized: true,
                                                                   tutorialWasShown: true)
                self.start()
            }
            self.addDependency(coordinator)
            coordinator.start()
        }
    }
}
