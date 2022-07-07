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
    
    @objc func showDeleteMovieAlert(_ gesture: UILongPressGestureRecognizer){
        if gesture.state == .began {
            guard let cell = gesture.view as? TableViewCell else { return }
            guard let indexPath = myTableView.indexPath(for: cell) else { return }
            let movie = viewModel.myMovies[indexPath.row]
            
            showDeleteMovieAlert(movie, handler: { alert in
                self.viewModel.myMovies.remove(at: indexPath.row)
                self.viewModel.saveMovies()
                self.myTableView.reloadData()
            })
        }
    }
    
    func showDeleteMovieAlert(_ movie: Movie, handler: @escaping (UIAlertAction) -> Void){
        let title = movie.title
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.left
        
        let genre_list = Genre_list(genre_ids: movie.genreIds)
        let details = movie.details()+genre_list.printGenres()
        
        let attributedMessageText = NSMutableAttributedString(
            string: details,
            attributes: [
                NSAttributedString.Key.paragraphStyle: paragraphStyle,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15.0)
            ]
        )
        
        alert.setValue(attributedMessageText, forKey: "attributedMessage")
        
        let backButton = UIAlertAction(title: "Back", style: .cancel)
        alert.addAction(backButton)
        
        let favoriteButton = UIAlertAction(title: "Delete", style: .destructive, handler: handler)
        alert.addAction(favoriteButton)
        
        present(alert, animated: true, completion: nil)
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
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(showDeleteMovieAlert(_:)))
        
        cell.addGestureRecognizer(longPress)
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


