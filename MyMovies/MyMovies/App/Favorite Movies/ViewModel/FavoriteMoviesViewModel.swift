//
//  FavoriteMoviesViewModel.swift
//  MyMovies
//
//  Created by Daniel de Andrade Souza on 05/07/22.
//

import Foundation

class FavoriteMoviesViewModel {
    
    var myMovies: [Movie] = []
    
    let movielist: MovieListViewController
    
    weak var delegate: FavoritesViewController?
    
    init(movielist: MovieListViewController = MovieListViewController()){
        self.movielist = movielist
        
        setupDelegates()
    }
    
    func setupDelegates(){
        movielist.favoritesDelegate = self
    }
    
}

// MARK: - FavoritesDelegate

extension FavoriteMoviesViewModel: FavoritesDelegate {
    func addFavorite(movie: Movie){
        DispatchQueue.main.async {
            self.myMovies.append(movie)
            self.delegate?.myTableView.reloadData()
            print("item \(movie.title) favorited")
        }
    }
}
