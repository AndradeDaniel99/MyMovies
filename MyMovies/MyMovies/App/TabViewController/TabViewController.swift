//
//  TabViewController.swift
//  MyMovies
//
//  Created by Daniel de Andrade Souza on 15/06/22.
//

import UIKit

class TabViewController: UITabBarController, UITabBarControllerDelegate {

    let movieListVC = MovieListViewController()
    let favoritesVC = FavoritesViewController()
    
    // this navigation controllers have one use: show the view title
    let movieListNavVC = UINavigationController()
    let favoritesNavVC = UINavigationController()
    
    override func loadView() {
        super.loadView()
        movieListNavVC.setViewControllers([movieListVC], animated: false)
        favoritesNavVC.setViewControllers([favoritesVC], animated: false)
        movieListVC.favoritesDelegate = favoritesVC.viewModel
        movieListVC.title = "Trending Movies"
        favoritesVC.title = "My Movies"
        view.backgroundColor = .white
        self.setViewControllers([movieListNavVC, favoritesNavVC], animated: false)
        guard let items = self.tabBar.items else { return }
        let images = ["house", "star"]
        for i in 0..<items.count {
            items[i].image = UIImage(systemName: images[i])
        }
        setFavoritesConstraints()
    }
    
    func setFavoritesConstraints(){
        favoritesVC.myTableView.translatesAutoresizingMaskIntoConstraints = false
        favoritesVC.myTableView.topAnchor.constraint(equalTo:  favoritesVC.view.topAnchor).isActive = true
        favoritesVC.myTableView.bottomAnchor.constraint(equalTo: favoritesVC.view.bottomAnchor).isActive = true
        favoritesVC.myTableView.leadingAnchor.constraint(equalTo: favoritesVC.view.leadingAnchor).isActive = true
        favoritesVC.myTableView.trailingAnchor.constraint(equalTo: favoritesVC.view.trailingAnchor).isActive = true
    }
}
