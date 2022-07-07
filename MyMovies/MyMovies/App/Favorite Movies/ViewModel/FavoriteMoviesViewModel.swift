//
//  FavoriteMoviesViewModel.swift
//  MyMovies
//
//  Created by Daniel de Andrade Souza on 05/07/22.
//

import Foundation

class FavoriteMoviesViewModel {
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("movies.plist")
    
    var myMovies: [Movie] = []
    
    let movielist: MovieListViewController
    
    weak var delegate: FavoritesViewController?
    
    init(movielist: MovieListViewController = MovieListViewController()){
        self.movielist = movielist
        loadMovies()
        setupDelegates()
    }
    
    func setupDelegates(){
        movielist.favoritesDelegate = self
    }
    
    func saveMovies(){
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(myMovies)
            if let dataFilePath = dataFilePath {
                try data.write(to: dataFilePath)
            }
        } catch  {
            print(error.localizedDescription)
        }
    }
    
    func loadMovies(){
        let decoder = PropertyListDecoder()
        do {
            if let dataFilePath = dataFilePath {
                let data = try Data(contentsOf: dataFilePath)
                myMovies = try decoder.decode([Movie].self, from: data)
            }
        } catch  {
            print(error.localizedDescription)
        }
    }
    
    func checkDoubledMovies(movie: Movie){
        var count = 0
        for myMovie in myMovies {
            if movie == myMovie {
                count += 1
            }
        }
        if count == 0 {
            myMovies.append(movie)
            saveMovies()
        }
    }
}

// MARK: - FavoritesDelegate

extension FavoriteMoviesViewModel: FavoritesDelegate {
    func addFavorite(movie: Movie){
        DispatchQueue.main.async {
            self.checkDoubledMovies(movie: movie)
            self.delegate?.myTableView.reloadData()
            print("item \(movie.title) favorited")
        }
    }
}
