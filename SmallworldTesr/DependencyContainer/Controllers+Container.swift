//
//  Controllers+Container.swift
//  SmallworldTesr
//
//  Created by Aijaz Ali on 21/10/2023.
//


import Moya
import Swinject
import SwinjectAutoregistration

extension Container {
    
    // MARK: ViewControllers
    func registerControllers() {
        
        // MARK: - Main Storyboard
        
        self.register(PopularMoviesViewController.self) { resolver -> PopularMoviesViewController in
            let vc = PopularMoviesViewController.instantiate(storyboard: .home)
            vc.viewModel = resolver.resolve(PopularMoviesViewModel.self)
            return vc
        }
        
        self.register(MovieDetailsViewController.self) { resolver -> MovieDetailsViewController in
            let vc = MovieDetailsViewController.instantiate(storyboard: .home)
            vc.viewModel = resolver.resolve(MovieDetailsViewModel.self)
            return vc
        }
    }
}
