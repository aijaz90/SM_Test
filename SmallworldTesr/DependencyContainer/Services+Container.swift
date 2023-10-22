//
//  Services+Container.swift
//  SmallworldTesr
//
//  Created by Aijaz Ali on 21/10/2023.
//

import Moya
import Swinject
import SwinjectAutoregistration

extension Container {
    
    // MARK: Others
    func registerServices() {
        // MARK: API Providers
        self.register(MoyaProvider<PopularMovieService>.self, factory: { _ in
            return MoyaProvider<PopularMovieService>(plugins: [RequestInterceptor()])
        })
       
        // MARK: API CALLS
        self.register(PopularMovieAPICall.self) { resolver -> PopularMovieAPICall in
            return PopularMovieAPICall(provider: resolver.resolve(MoyaProvider<PopularMovieService>.self)!)
        }
    }
}
