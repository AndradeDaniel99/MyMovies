//
//  FavoritesViewController.swift
//  MyMovies
//
//  Created by Daniel de Andrade Souza on 15/06/22.
//

import UIKit

protocol FavoritesDelegate: AnyObject {
    func favoriteHandler(movie: Movie)
}

class FavoritesViewController: UIViewController {

    weak var delegate: FavoritesDelegate?
    
    var myMovies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        title = "My Movies"
    }
}
