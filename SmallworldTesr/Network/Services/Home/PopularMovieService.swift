//
//  PopularMovieListService.swift
//  SmallworldTesr
//
//  Created by Aijaz Ali on 21/10/2023.
//

import Foundation
import Moya

enum PopularMovieService {
    case getMovieDetails(movieId: Int?)
    case getPopularMovies(page: Int?, sortBy: String?)
}

extension PopularMovieService: TargetType {
    
    var baseURL: URL {
        return EndPoints.baseURL.url
    }
    
    var path: String {
        switch self {
            case .getMovieDetails(let id):
            return EndPoints.MovieDetails.getMovieDetails(movieID: id)
            case .getPopularMovies:
            return EndPoints.Movies.popular
        }
    }
    
    var method: Moya.Method {
        switch self {
            case .getMovieDetails,
                 .getPopularMovies:
                return .get
        }
    }
    
    var sampleData: Data {
        return """
            [{
            "movieId": 5,
            "id": 46,
            "title": "post title",
            "body": "body text"
            }]
            """.data(using: String.Encoding.utf8) ?? Data()
    }
    
    var task: Task {
        switch self {
        case .getMovieDetails:
            var params: [String: Any] = [:]
            params["language"] = "en-US"
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        case .getPopularMovies(page: let page, sortBy: let sortBy):
            var params: [String: Any] = [:]
            if let page = page { params["page"] = page }
            if let sortBy = sortBy { params["sort_by"] = sortBy }
            params["language"] = "en-US"
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String: String]? {
        return ["Authorization": Constants.API.apiReadAccessToken]
    }
}
