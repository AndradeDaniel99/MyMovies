//
//  SelectedMovieView.swift
//  MyMovies
//
//  Created by Daniel de Andrade Souza on 30/06/22.
//

import UIKit

class SelectedMovieView: UIView {

    let movieTitle: UILabel = {
        let title: UILabel = UILabel()
        title.font.withSize(18)
        title.textAlignment = .left
        title.numberOfLines = 0
        title.textColor = .black
        //title.backgroundColor = .blue.withAlphaComponent(0.5)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    func setupView(movie: Movie){
        movieTitle.text = movie.title
        setupViewHierarchy()
        setupConstraints()
    }

    func setupViewHierarchy(){
        addSubview(movieTitle)
    }
    
    func setupConstraints(){
        let constraints = [
            movieTitle.centerYAnchor.constraint(equalTo: centerYAnchor),
            movieTitle.centerXAnchor.constraint(equalTo: centerXAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
