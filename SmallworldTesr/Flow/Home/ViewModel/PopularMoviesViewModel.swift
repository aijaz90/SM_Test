//
//  PopularMoviesViewModel.swift
//  SmallworldTesr
//
//  Created by Aijaz Ali on 20/10/2023.
//

import Foundation
import RxSwift

protocol PopularMoviesViewModelDelegate: AnyObject {
    func didGetPopularMovieList()
    func didGetSortMoviesList()
    func didGetAnError(description: String)
}


class PopularMoviesViewModel {
    
    weak var delegate: PopularMoviesViewModelDelegate?
    private let disposeBag = DisposeBag()
    private let apicalls: PopularMovieAPICall
    
    var popularMoviesList: [Movie] = []
    
    // MARK: - Paging Variables
    private var page = 1
    private var limit = 20
    private var isLoading = false
    private var firstTimeLoading = true
    private var isMoreDataAvailable = true
    
    public var sortBy: MoviesFetchDirection = .descending
    
    init(apicalls: PopularMovieAPICall) {
        self.apicalls = apicalls
    }
    
    func getPopularMoviesList() {
        self.apicalls.getPopularMovies(page: self.page, sortBy: self.sortBy.descriptionValue).subscribe( onSuccess: { [weak self] model in
            if let popularMoviesList = model {
                if self?.page == 1 {
                    self?.popularMoviesList.removeAll()
                }
                let movieList = popularMoviesList.results ?? []
                self?.popularMoviesList.append(contentsOf: movieList)
                self?.isMoreDataAvailable = (self?.popularMoviesList.count ?? 0) < popularMoviesList.totalResults ?? 0
                self?.isLoading = false
                self?.delegate?.didGetPopularMovieList()
                self?.page += 1
            }
        }, onError: { err in
            self.delegate?.didGetAnError(description: "Error: \(err.localizedDescription)")
        }).disposed(by: disposeBag)
    }
    
    func getSortedMovie(isAscending: Bool ) {
        self.page = 1
        self.sortBy = isAscending ? .ascending : .descending
        self.getPopularMoviesList()
        
    }
    
    /// Used for pull to refresh
    func resetAllData() {
        self.page = 1
        self.isLoading = true
        self.getPopularMoviesList()
    }
}
