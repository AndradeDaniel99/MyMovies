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
        //title.font.withSize(22)
        title.font = UIFont.boldSystemFont(ofSize: 18)
        title.textAlignment = .left
        title.numberOfLines = 0
        title.textColor = .darkGray
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
    
    let releaseDate: UILabel = {
        let releaseDate: UILabel = UILabel()
        releaseDate.font.withSize(18)
        releaseDate.textAlignment = .left
        releaseDate.numberOfLines = 0
        releaseDate.textColor = .lightGray
        releaseDate.translatesAutoresizingMaskIntoConstraints = false
        return releaseDate
    }()
    
    func setupView(movie: Movie){
        movieTitle.text = movie.title
        releaseDate.text = movie.release_date
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
        addSubview(releaseDate)
    }
    
    func setupConstraints(){
        let constraints = [
            backdrop.topAnchor.constraint(equalTo: topAnchor),
            backdrop.leadingAnchor.constraint(equalTo: leadingAnchor),
            backdrop.trailingAnchor.constraint(equalTo: trailingAnchor),
            backdrop.heightAnchor.constraint(equalToConstant: 180),
            
            movieTitle.topAnchor.constraint(equalTo: backdrop.bottomAnchor, constant: 20),
            movieTitle.leadingAnchor.constraint(equalTo: leadingAnchor),
            movieTitle.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            releaseDate.topAnchor.constraint(equalTo: movieTitle.bottomAnchor),
            releaseDate.leadingAnchor.constraint(equalTo: leadingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
