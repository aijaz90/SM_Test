//
//  MovieDetailsViewModel.swift
//  SmallworldTesr
//
//  Created by Aijaz Ali on 20/10/2023.
//

import Foundation
import RxSwift

protocol MovieDetailsViewModelDelegate: AnyObject {
    func didGetMovieDetails(list: MovieDetailsModel)
    func didGetAnError(description: String)
}


class MovieDetailsViewModel {
    
    weak var delegate: MovieDetailsViewModelDelegate?
    private let disposeBag = DisposeBag()
    private let apicalls: PopularMovieAPICall
    public var movieId: Int?
    
    init(apicalls: PopularMovieAPICall) {
        self.apicalls = apicalls
    }
    
    func getMovieDetails() {
        guard let movieId = movieId else { return }
        self.apicalls.getMovieDetails(movieId: movieId).subscribe( onSuccess: { model in
            if let movieDetails = model {
                self.delegate?.didGetMovieDetails(list: movieDetails )
            }
        }, onError: { err in
            self.delegate?.didGetAnError(description: err.localizedDescription)
        }).disposed(by: disposeBag)
    }
}
