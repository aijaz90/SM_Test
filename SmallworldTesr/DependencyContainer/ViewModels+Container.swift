//
//  ViewModels+Container.swift
//  SmallworldTesr
//
//  Created by Aijaz Ali on 21/10/2023.
//

import Moya
import Swinject
import SwinjectAutoregistration

extension Container {
    
    // MARK: Register All
    func registerAll() {
        self.registerViewModels()
        self.registerCoordinators()
        self.registerControllers()
        self.registerServices()
    }
    
    // MARK: ViewModels
    func registerViewModels() {
        // All ViewModels will register here
        // IMPORTANT: Must register all viewmodels via autoregister function.
        
        // MARK: - Auth View Models
        self.autoregister(PopularMoviesViewModel.self, initializer: PopularMoviesViewModel.init)
        self.autoregister(MovieDetailsViewModel.self, initializer: MovieDetailsViewModel.init)
    }
}
