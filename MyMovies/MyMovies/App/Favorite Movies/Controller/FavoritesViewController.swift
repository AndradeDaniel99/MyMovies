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

    let myTableView = UITableView()
    
    let viewModel = FavoriteMoviesViewModel()
    
    // MARK: - LifeCycle
    
    override func loadView() {
        super.loadView()
        title = "My Movies"
        viewModel.delegate = self
        setupTableView()
    }
    
    // MARK: - Methods
    
    func setupTableView(){
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        myTableView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight);
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.register(TableViewCell.self, forCellReuseIdentifier: "Cell")
        myTableView.backgroundColor = .white
        myTableView.rowHeight = 131
        view.addSubview(myTableView)
    }
    
}

// MARK: - UITableViewDataSource

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.myMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? TableViewCell else { return UITableViewCell() }
        let genreList = Genre_list(genre_ids: viewModel.myMovies[indexPath.row].genreIds).printGenres()
        
        cell.setupCell(posterUrl: viewModel.myMovies[indexPath.row].posterPath ,title: viewModel.myMovies[indexPath.row].title, genres: genreList)
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = viewModel.myMovies[indexPath.row]
        
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(SelectedMovieViewController(movie: movie, hideFavButton: true), animated: false)
    }
}


