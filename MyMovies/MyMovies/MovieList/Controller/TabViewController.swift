//
//  TabViewController.swift
//  MyMovies
//
//  Created by Daniel de Andrade Souza on 15/06/22.
//

import UIKit

class TabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let movieListVC = MovieListViewController()
        let favoritesVC = FavoritesViewController()
        
        movieListVC.title = "Movies"
        favoritesVC.title = "Favorites"
        
        self.setViewControllers([movieListVC, favoritesVC], animated: false)
        
        guard let items = self.tabBar.items else { return }
        
        let images = ["house", "star"]
        
        for i in 0..<items.count {
            items[i].image = UIImage(systemName: images[i])
        }
    }
    

    

}
