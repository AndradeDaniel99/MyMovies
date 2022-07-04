//
//  FavoritesViewController.swift
//  MyMovies
//
//  Created by Daniel de Andrade Souza on 15/06/22.
//

import UIKit
import Kingfisher

class FavoritesViewController: UIViewController {
    // MARK: - atributes
    
    var myMovies: [Movie] = []
    
    let myTableView = UITableView()
    
    let movielist = MovieListViewController()
    
    // MARK: - LifeCycle
    
    override func loadView() {
        super.loadView()
        title = "My Movies"
        setupTableView()
        movielist.favoritesDelegate = self
    }
    
    // MARK: - Methods
    
    func setupTableView(){
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        myTableView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight);
        myTableView.dataSource = self
        myTableView.register(TableViewCell.self, forCellReuseIdentifier: "Cell")
        myTableView.backgroundColor = .white
        myTableView.rowHeight = 131
        view.addSubview(myTableView)
    }
    
}

// MARK: - UITableViewDataSource

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        myMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: TableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? TableViewCell else { return UITableViewCell() }
        let genreList = Genre_list(genre_ids: myMovies[indexPath.row].genre_ids).printGenres()
        cell.setupCell(posterUrl: self.myMovies[indexPath.row].poster_path ,title: self.myMovies[indexPath.row].title, genres: genreList)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = myMovies[indexPath.row]
        navigationController?.pushViewController(SelectedMovieViewController(movie: movie, buttonBool: true), animated: false)
        print("\(movie.title) selected")
        print("selected")
    }
}

// MARK: - FavoritesDelegate

extension FavoritesViewController: FavoritesDelegate {
    func addFavorite(movie: Movie){
        DispatchQueue.main.async {
            self.myMovies.append(movie)
            self.myTableView.reloadData()
            print("item \(movie.title) favorited")
        }
    }
}
