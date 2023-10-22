//
//  PopularMovieAPICall.swift
//  SmallworldTesr
//
//  Created by Aijaz Ali on 21/10/2023.
//

import Moya
import RxSwift
import SwiftyJSON

class PopularMovieAPICall {
    
    private let provider: MoyaProvider<PopularMovieService>
    
    init(provider: MoyaProvider<PopularMovieService>) {
        self.provider = provider
    }
    
    // MARK: GET POPULAR MOVIE LIST CALL
    func getMovieDetails(movieId: Int) -> Single<MovieDetailsModel?> {
        let service: PopularMovieService = .getMovieDetails(movieId: movieId)
        return provider.rx
            .request(service)
            .filterSuccessfulStatusAndRedirectCodes()
            .map({
                debugPrint(JSON($0.dict as Any))
                return $0
            }).map(MovieDetailsModel?.self)
    }
    
    // MARK: - GET MOVIE DETAILS CALL

    func getPopularMovies(page: Int?, sortBy: String?) -> Single<PopularMoviesModel?> {
        let service: PopularMovieService = .getPopularMovies(page: page, sortBy: sortBy)
        return provider.rx
            .request(service)
            .filterSuccessfulStatusAndRedirectCodes()
            .map({
                debugPrint(JSON($0.dict as Any))
                return $0
            }).map(PopularMoviesModel?.self)
    }
}
