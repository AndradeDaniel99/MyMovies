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
        cell.setupCell(posterUrl: self.myMovies[indexPath.row].poster_path ,title: self.myMovies[indexPath.row].title)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension FavoritesViewController: UITableViewDelegate {
    
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
