//
//  SelectedMovieView.swift
//  MyMovies
//
//  Created by Daniel de Andrade Souza on 30/06/22.
//

import UIKit
import Kingfisher

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
    
    let backdrop: UIImageView = {
        let backdrop: UIImageView = UIImageView()
        backdrop.contentMode = .scaleAspectFill
        backdrop.clipsToBounds = true
        backdrop.translatesAutoresizingMaskIntoConstraints = false
        return backdrop
    }()
    
    func setupView(movie: Movie){
        movieTitle.text = movie.title
        let preUrl = "https://image.tmdb.org/t/p/w780/"
        let url = URL.init(string: preUrl+movie.backdrop_path)
        self.backdrop.kf.indicatorType = .activity
        self.backdrop.kf.setImage(with: url)
        setupViewHierarchy()
        setupConstraints()
    }

    func setupViewHierarchy(){
        addSubview(backdrop)
        addSubview(movieTitle)
    }
    
    func setupConstraints(){
        let constraints = [
            backdrop.topAnchor.constraint(equalTo: topAnchor),
            backdrop.leadingAnchor.constraint(equalTo: leadingAnchor),
            backdrop.trailingAnchor.constraint(equalTo: trailingAnchor),
            backdrop.heightAnchor.constraint(equalToConstant: 180),
            
            movieTitle.centerYAnchor.constraint(equalTo: centerYAnchor),
            movieTitle.centerXAnchor.constraint(equalTo: centerXAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
