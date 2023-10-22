//
//  MovieDetailsViewController.swift
//  SmallworldTesr
//
//  Created by Aijaz Ali on 21/10/2023.
//

import UIKit

class MovieDetailsViewController: BaseControler {
    var viewModel: MovieDetailsViewModel?
    
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()
    }
    
    
    private func prepareView() {
        self.viewModel?.delegate = self
        self.startActivityIndicator()
        self.viewModel?.getMovieDetails()
        self.navigationBarTransparent()
        
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

extension MovieDetailsViewController: MovieDetailsViewModelDelegate {
    func didGetAnError(description: String) {
        self.stopActivityIndicator()
        self.showToast(text: description)
    }
    
    func didGetMovieDetails(list: MovieDetailsModel) {
        DispatchQueue.main.async {
            self.movieNameLabel.text = list.originalTitle
            self.movieDescriptionLabel.text = list.overview
            self.stopActivityIndicator()
        }
    }
}
