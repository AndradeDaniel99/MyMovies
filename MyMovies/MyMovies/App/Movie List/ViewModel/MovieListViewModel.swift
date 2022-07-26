//
//  MovieListViewModel.swift
//  MyMovies
//
//  Created by Daniel de Andrade Souza on 05/07/22.
//

import Foundation

class MovieListViewModel {
    
    // MARK: - Atributes

    var movies: [Movie] = []
    
    var movieManager: MovieManaging
    
    var page = 1
    
    weak var delegate: MovieListViewController?
    
    init(movieManager: MovieManaging = MovieManager()) {
        self.movieManager = movieManager
    }
    
    // MARK: - methods
        
    func fetchMovies(completion: (() -> Void)? = nil) {
        movieManager.fetchMovie(String(page)) { movies in
            DispatchQueue.main.async {
                self.movies += movies
                self.delegate?.myCollectionView.reloadData()
                completion?()
            }
        }
    }
    
}
