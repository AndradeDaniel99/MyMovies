//
//  MovieDetailsViewController.swift
//  MyMovies
//
//  Created by Daniel de Andrade Souza on 14/06/22.
//

import UIKit

class MovieDetailsViewController {

    let controller: UIViewController
    
    init(controller: UIViewController){
        self.controller = controller
    }
    
    func showDetails(_ movie: Movie, handler: @escaping (UIAlertAction) -> Void){
        let alert = UIAlertController(title: movie.title, message: movie.details(), preferredStyle: .alert)

        let backButton = UIAlertAction(title: "Back", style: .cancel)
        alert.addAction(backButton)
        
        let favoriteButton = UIAlertAction(title: "Add favorite", style: .destructive, handler: handler)
        alert.addAction(favoriteButton)
        
        controller.present(alert, animated: true, completion: nil)
    }

}
