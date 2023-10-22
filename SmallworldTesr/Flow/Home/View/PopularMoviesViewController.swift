//
//  PopularMoviesViewController.swift
//  SmallworldTesr
//
//  Created by Aijaz Ali on 20/10/2023.
//

import DropDown
import UIKit

// MARK: Navigations
enum PopularMoviesVCActions {
    case getMovieDetails(movieId: Int)
}

class PopularMoviesViewController: BaseControler {
    
    @IBOutlet weak var sortButton: UIButton!
    @IBOutlet weak var nointernetLabel: UILabel!
    public var performAction: ClosureData<PopularMoviesVCActions>?
    public var viewModel: PopularMoviesViewModel?
    
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var popularMoviesTableView: UITableView!
    
    private let dropDown = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()
    }
    
    private func prepareView() {
        self.dropDown.anchorView = self.sortButton
        self.dropDown.dataSource = ["Ascending", "Descending"]
        self.dropDown.width = 200
        self.startActivityIndicator()
        self.viewModel?.delegate = self
        self.viewModel?.getPopularMoviesList()
        self.popularMoviesTableView.delegate = self
        self.popularMoviesTableView.dataSource = self
        self.popularMoviesTableView.register(UINib(nibName: TableViewCells.PopularMovies.popularMoviesTVCell, bundle: nil), forCellReuseIdentifier: TableViewCells.PopularMovies.popularMoviesTVCell)
    }
    
    @IBAction func sortedButtonTapped(_ sender: UIButton) {
        self.dropDown.show()
        self.dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.dropDown.hide()
            self.startActivityIndicator()
            self.viewModel?.getSortedMovie( isAscending: index == 0)
        }
    }
    
    private func stopActivityIndicator() {
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
    }
    
    private func startActivityIndicator() {
        self.activityIndicator.startAnimating()
        self.activityIndicator.isHidden = false
    }
}

extension PopularMoviesViewController: PopularMoviesViewModelDelegate {
    func didGetSortMoviesList() {
        self.popularMoviesTableView.reloadData()
        self.stopActivityIndicator()
    }
    
    func didGetAnError(description: String) {
        self.stopActivityIndicator()
        self.showToast(text: description)
    }
    
    func didGetPopularMovieList() {
        self.popularMoviesTableView.reloadData()
        self.stopActivityIndicator()
        
    }
}

extension PopularMoviesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.popularMoviesList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCells.PopularMovies.popularMoviesTVCell, for: indexPath) as? popularMoviesTVCell else { return UITableViewCell() }
        cell.titleLabel.text = viewModel?.popularMoviesList[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == (viewModel?.popularMoviesList.count ?? 0) - 1 {
            self.startActivityIndicator()
            self.viewModel?.getPopularMoviesList()
        }
    }
}

extension PopularMoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let movieId = viewModel?.popularMoviesList[indexPath.row].id else { return }
        self.performAction?(.getMovieDetails(movieId: movieId))
    }
}
