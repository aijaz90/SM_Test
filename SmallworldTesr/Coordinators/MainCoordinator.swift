//
//  MainCoordinator.swift
//  SmallworldTesr
//
//  Created by Aijaz Ali on 21/10/2023.
//

import UIKit

class MainCoordinator: BaseCoordinator {
    
    // MARK: Vars and Lets
    private let routerProtocol: RouterProtocol
    
    init(routerProtocol: RouterProtocol) {
        self.routerProtocol = routerProtocol
    }
    
    override func start() {
        self.showLoginScreen()
    }
    
    
    
    private func showLoginScreen() {
        guard let popularMovieVC = AppDelegate.container.resolve(PopularMoviesViewController.self) else { return }
        
        popularMovieVC.performAction = { [unowned self] actionType in
            switch actionType {
            case .getMovieDetails(movieId: let id):
                self.showMovieDetails(movieId: id)
            }
        }
        popularMovieVC.hidesBottomBarWhenPushed = true
        self.routerProtocol.push(popularMovieVC)
    }
    
    private func showMovieDetails(movieId: Int) {
        guard let movieDetailsVC = AppDelegate.container.resolve(MovieDetailsViewController.self) else { return }
        movieDetailsVC.viewModel?.movieId = movieId
        // movieDetailsVC.hidesBottomBarWhenPushed = true
        self.routerProtocol.push(movieDetailsVC)
    }
}
