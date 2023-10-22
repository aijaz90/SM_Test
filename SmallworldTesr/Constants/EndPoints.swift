//
//  EndPoints.swift
//  SmallworldTesr
//
//  Created by Aijaz Ali on 21/10/2023.
//

import Foundation

enum EndPoints {
    // MARK: API's
    static let baseURL = "https://api.themoviedb.org/3/"
    static let language = "language=en-US"
}

// MARK: Movie Services
extension EndPoints {
    enum Movies {
        static let popular = "discover" / "movie" 
    }
    
    enum MovieDetails {
        static func getMovieDetails(movieID id: Int?) -> String { "movie" / (id?.toString ?? "0") }
    }
}
