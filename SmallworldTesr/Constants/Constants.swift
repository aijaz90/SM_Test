//
//  Constants.swift
//  SmallworldTesr
//
//  Created by Aijaz Ali on 20/10/2023.
//

import Foundation

//let apiKey = "02c63f64de10988b2ad0044727a718b6"

enum Constants {
    enum API {
        static let apiReadAccessToken = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwMmM2M2Y2NGRlMTA5ODhiMmFkMDA0NDcyN2E3MThiNiIsInN1YiI6IjY1MzE4YTJjNmQ5ZmU4MDBjNGE4NTk5NiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.MWv6DcHFS9MDrZ3UHkK2AutAvQuRP6YJ557jrJzhb6A"
    }
}

enum TableViewCells {
    enum PopularMovies {
        static let popularMoviesTVCell = "popularMoviesTVCell"
    }
}

enum Errors {
    enum Internet {
        static let noInternet = "Internet Connection not Available!"
        static let emptyList = "The list is empty!"
    }
}
