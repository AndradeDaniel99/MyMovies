//
//  FavoritesViewController.swift
//  MyMovies
//
//  Created by Daniel de Andrade Souza on 15/06/22.
//

import UIKit
import Kingfisher

class FavoritesViewController: UIViewController, UITableViewDataSource {
    
    var myMovies: [Movie] = []
    
    let myTableView = UITableView()
    
    let movielist = MovieListViewController()
    
    override func loadView() {
        super.loadView()
        title = "My Movies"
        setupTableView()
        movielist.favoritesDelegate = self
    }
    
    func setupTableView(){
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        myTableView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight);
        myTableView.dataSource = self
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        myTableView.backgroundColor = .white
        view.addSubview(myTableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        myMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = myMovies[indexPath.row].title
        // content.image =
        cell.contentConfiguration = content
        return cell
    }
}

extension FavoritesViewController: FavoritesDelegate {
    func addFavorite(movie: Movie){
        DispatchQueue.main.async {
            self.myMovies.append(movie)
            self.myTableView.reloadData()
            print("item \(movie.title) favorited")
        }
    }
}
