//
//  FavoritesViewController.swift
//  MyMovies
//
//  Created by Daniel de Andrade Souza on 15/06/22.
//

import UIKit



class FavoritesViewController: UIViewController {

    
    var myMovies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        title = "My Movies"
    }
}

extension FavoritesViewController: FavoritesDelegate {
    func favoriteHandler(movie: Movie){
        //self.myMovies.append(movie)
        print("item \(movie.title) favorited")
    }
}
