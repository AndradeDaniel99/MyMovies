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
        let title = movie.title
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.left
        let genre_list = Genre_list(genre_ids: movie.genre_ids)
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
        
        let favoriteButton = UIAlertAction(title: "Add favorite", style: .destructive, handler: handler)
        alert.addAction(favoriteButton)
        
        controller.present(alert, animated: true, completion: nil)
    }

}
