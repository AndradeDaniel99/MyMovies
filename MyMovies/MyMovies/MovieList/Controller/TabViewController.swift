//
//  TabViewController.swift
//  MyMovies
//
//  Created by Daniel de Andrade Souza on 15/06/22.
//

import UIKit

class TabViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        self.delegate = self
        let movieListVC = UINavigationController(rootViewController: MovieListViewController())
        let favoritesVC = UINavigationController(rootViewController: FavoritesViewController())

        movieListVC.title = "Movies"
        favoritesVC.title = "Favorites"

        self.setViewControllers([movieListVC, favoritesVC], animated: false)

        guard let items = self.tabBar.items else { return }
        let images = ["house", "star"]
        for i in 0..<items.count {
            items[i].image = UIImage(systemName: images[i])
        }
        
        
        
    }
    
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        let moviesTab = UINavigationController(rootViewController: MoviesViewController())
//        let moviesTabBarItem = UITabBarItem(title: "Movies", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house"))
//        moviesTab.tabBarItem = moviesTabBarItem
//
//        let favoritesTab = UINavigationController(rootViewController: FavoritesViewController())
//        let favoritesTabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "star"), selectedImage: UIImage(systemName: "star"))
//        favoritesTab.tabBarItem = favoritesTabBarItem
//
//        self.viewControllers = [moviesTab, favoritesTab]
//
//    }
//
    

}
