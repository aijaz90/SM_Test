//
//  BaseCoordinator.swift
//  SmallworldTesr
//
//  Created by Aijaz Ali on 21/10/2023.
//

import Foundation

typealias Closure = (() -> Void)
typealias ClosureData<T> = ((T) -> Void)

typealias ClosureWithOptionalData<T> = ((T?) -> Void)

enum CoordinatorData<T> {
    case someData(T), noData
}

class BaseCoordinator: NSObject, Coordinator, CoordinatorFinishOutput {
    var finishFlow: (() -> Void)?
    
    // MARK: - Vars & Lets
    
    var childCoordinators = [Coordinator]()
    
    // MARK: - Public methods
    
    func addDependency(_ coordinator: Coordinator) {
        for element in childCoordinators where element === coordinator { return }
        childCoordinators.append(coordinator)
    }
    
    func removeDependency(_ coordinator: Coordinator?) {
        guard childCoordinators.isEmpty == false, let coordinator = coordinator else { return }
        
        for (index, element) in childCoordinators.enumerated() where element === coordinator {
            childCoordinators.remove(at: index)
            break
        }
    }
    // MARK: - Coordinator
    
    func start() {
        start(with: nil)
    }
    
    func start(with option: DeepLinkOption?) {
    }
}
