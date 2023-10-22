//
//  Coordinators+Container.swift
//  SmallworldTesr
//
//  Created by Aijaz Ali on 21/10/2023.
//

import Moya
import Swinject
import SwinjectAutoregistration


extension Container {
    // MARK: App Coordinator - Starting point
    func resolveAppCoordinator(rootController: UINavigationController) -> AppCoordinator? {
        self.register(RouterProtocol.self) {[unowned rootController] _ -> RouterProtocol in
            return Router(rootController: rootController)
        }
        self.register(LaunchInstructor.self) { _ -> LaunchInstructor in return LaunchInstructor.configure() }
        self.register(AppCoordinator.self) { res -> AppCoordinator in
            return AppCoordinator(router: res.resolve(RouterProtocol.self)!, launchInstructor: res.resolve(LaunchInstructor.self)!)
        }
        return self.resolve(AppCoordinator.self)
    }
    
    // MARK: Coordinators
    func registerCoordinators() {
        // All Coordinators will register here
        self.autoregister(MainCoordinator.self, initializer: MainCoordinator.init)
        self.register(MainCoordinator.self) { (_, router) -> MainCoordinator in
            return MainCoordinator(routerProtocol: router)
        }
        
        self.autoregister(MainCoordinator.self, initializer: MainCoordinator.init)
    }
    
}
