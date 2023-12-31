//
//  Router.swift
//  SmallworldTesr
//
//  Created by Aijaz Ali on 21/10/2023.
//

import UIKit

protocol RouterProtocol: Presentable {

    func present(_ module: Presentable?)
    func present(_ module: Presentable?, animated: Bool)
    func present(_ module: Presentable?, animated: Bool, modalPresentationSytle: UIModalPresentationStyle)
    func present(_ module: Presentable?, animated: Bool, completion: (() -> Void)?)

    func push(_ module: Presentable?)
    func push(_ module: Presentable?, transition: UIViewControllerAnimatedTransitioning?)
    func push(_ module: Presentable?, transition: UIViewControllerAnimatedTransitioning?, animated: Bool)
    func push(_ module: Presentable?,
              transition: UIViewControllerAnimatedTransitioning?,
              animated: Bool, completion: (() -> Void)?)

    func popModule()
    func popModule(transition: UIViewControllerAnimatedTransitioning?)
    func popModule(transition: UIViewControllerAnimatedTransitioning?, animated: Bool)

    func dismissModule()
    func dismissModule(animated: Bool, completion: (() -> Void)?)

    func setRootModule(_ module: Presentable?)
    func setRootModule(_ module: Presentable?, hideBar: Bool)

    func popToRootModule(animated: Bool)
    func popToModule(module: Presentable?, animated: Bool)

    func showTitles()
    func hideTitles()
}

final class Router: NSObject, RouterProtocol {

    // MARK: - Vars & Lets

    private weak var rootController: UINavigationController?
    private var completions: [UIViewController : () -> Void]
    private var transition: UIViewControllerAnimatedTransitioning?

    // MARK: - Presentable

    func toPresent() -> UIViewController? {
        return self.rootController
    }

    // MARK: - RouterProtocol

    func present(_ module: Presentable?) {
        self.present(module, animated: true)
    }

    func present(_ module: Presentable?, animated: Bool) {
        guard let controller = module?.toPresent() else { return }
        self.rootController?.present(controller, animated: animated, completion: nil)
    }

    func present(_ module: Presentable?, animated: Bool, modalPresentationSytle: UIModalPresentationStyle) {
        guard let controller = module?.toPresent() else { return }
        controller.modalPresentationStyle = modalPresentationSytle
        self.rootController?.present(controller, animated: animated, completion: nil)
    }

    func present(_ module: Presentable?, animated: Bool, completion: (() -> Void)?) {
        guard let controller = module?.toPresent() else { return }
        self.rootController?.present(controller, animated: animated, completion: completion)
    }

    func push(_ module: Presentable?) {
        self.push(module, transition: nil)
    }

    func push(_ module: Presentable?, transition: UIViewControllerAnimatedTransitioning?) {
        self.push(module, transition: transition, animated: true)
    }

    func push(_ module: Presentable?, transition: UIViewControllerAnimatedTransitioning?, animated: Bool) {
        self.push(module, transition: transition, animated: animated, completion: nil)
    }

    func push(_ module: Presentable?,
              transition: UIViewControllerAnimatedTransitioning?,
              animated: Bool, completion: (() -> Void)?) {
        self.transition = transition
        guard let controller = module?.toPresent(),
            (controller is UINavigationController == false)
            else { assertionFailure("Deprecated push UINavigationController."); return }

        if let completion = completion {
            self.completions[controller] = completion
        }
        self.rootController?.pushViewController(controller, animated: animated)
    }

    func popModule() {
        self.popModule(transition: nil)
    }

    func popModule(transition: UIViewControllerAnimatedTransitioning?) {
        self.popModule(transition: transition, animated: true)
    }

    func popModule(transition: UIViewControllerAnimatedTransitioning?, animated: Bool) {
        self.transition = transition
        if let controller = rootController?.popViewController(animated: animated) {
            self.runCompletion(for: controller)
        }
    }

    func popToModule(module: Presentable?, animated: Bool = true) {
        if let controllers = self.rootController?.viewControllers, let module = module {
            for controller in controllers where controller == module as? UIViewController {
                self.rootController?.popToViewController(controller, animated: animated)
                self.runCompletion(for: controller)
            }
        }
    }

    func dismissModule() {
        self.dismissModule(animated: true, completion: nil)
    }

    func dismissModule(animated: Bool, completion: (() -> Void)?) {
        self.rootController?.dismiss(animated: animated, completion: completion)
    }

    func setRootModule(_ module: Presentable?) {
        self.setRootModule(module, hideBar: false)
    }

    func setRootModule(_ module: Presentable?, hideBar: Bool) {
        guard let controller = module?.toPresent() else { return }
        self.rootController?.setViewControllers([controller], animated: false)
        self.rootController?.isNavigationBarHidden = hideBar
    }

    func popToRootModule(animated: Bool) {
        if let controllers = self.rootController?.popToRootViewController(animated: animated) {
            controllers.forEach { controller in
                self.runCompletion(for: controller)
            }
        }
    }

    func showTitles() {
        self.rootController?.isNavigationBarHidden = false
        self.rootController?.navigationBar.prefersLargeTitles = true
        self.rootController?.navigationBar.tintColor = UIColor.black
    }

    func hideTitles() {
        self.rootController?.isNavigationBarHidden = true
    }

    // MARK: - Private methods

    private func runCompletion(for controller: UIViewController) {
        guard let completion = self.completions[controller] else { return }
        completion()
        completions.removeValue(forKey: controller)
    }

    // MARK: - Init methods
    init(rootController: UINavigationController) {
        self.rootController = rootController
        self.completions = [:]
        super.init()
        self.rootController?.delegate = self
    }
}

// MARK: - UINavigationControllerDelegate
extension Router: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController,
                              didShow viewController: UIViewController, animated: Bool) {
        // Read the view controller we’re moving from.
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }

        // Check whether our view controller array already contains that view controller.
        // If it does it means we’re pushing a different view controller on top rather than popping it, so exit.
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }

        // We’re still here – it means we’re popping the view controller,
        // so we can check whether it’s a view controller that conforms protocol BaseNavigationBackProtocol
        if let baseNavigationProtocol = fromViewController as? BaseNavigationBackProtocol {
            // We're popping a view controller; end its coordinator
            debugPrint("On Back Transaction()")
            baseNavigationProtocol.onNavigationBackButtonTap?()
        }
    }
}
