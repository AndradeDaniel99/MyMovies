//
//  SelectedMovieView.swift
//  MyMovies
//
//  Created by Daniel de Andrade Souza on 30/06/22.
//

import UIKit
import Kingfisher

class SelectedMovieView: UIView {
    
    let backdrop: UIImageView = {
        let backdrop: UIImageView = UIImageView()
        backdrop.contentMode = .scaleAspectFill
        backdrop.clipsToBounds = true
        backdrop.translatesAutoresizingMaskIntoConstraints = false
        return backdrop
    }()
    
    let movieTitle: UILabel = {
        let title: UILabel = UILabel()
        title.font = UIFont.boldSystemFont(ofSize: 18)
        title.textAlignment = .left
        title.numberOfLines = 0
        title.textColor = .darkGray
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    let releaseDate: UILabel = {
        let releaseDate: UILabel = UILabel()
        releaseDate.font.withSize(16)
        releaseDate.textAlignment = .left
        releaseDate.numberOfLines = 0
        releaseDate.textColor = .lightGray
        releaseDate.translatesAutoresizingMaskIntoConstraints = false
        return releaseDate
    }()
    
    let genres: UILabel = {
        let genres: UILabel = UILabel()
        genres.font.withSize(16)
        genres.textAlignment = .left
        genres.numberOfLines = 0
        genres.textColor = .lightGray
        genres.translatesAutoresizingMaskIntoConstraints = false
        return genres
    }()
    
    let overview: UILabel = {
        let overview: UILabel = UILabel()
        overview.font.withSize(18)
        overview.textAlignment = .left
        overview.numberOfLines = 0
        overview.textColor = .gray
        overview.translatesAutoresizingMaskIntoConstraints = false
        return overview
    }()
    
    let whereToWatch: UILabel = {
        let title: UILabel = UILabel()
        title.font = UIFont.boldSystemFont(ofSize: 18)
        title.textAlignment = .left
        title.numberOfLines = 0
        title.textColor = .gray
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    let streamProvider: UILabel = {
        let title: UILabel = UILabel()
        title.font.withSize(24)
        title.textAlignment = .left
        title.numberOfLines = 0
        title.textColor = .gray
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    let favoriteButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        button.setTitle("Make My Movie", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .cyan
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func setupView(movie: Movie){
        movieTitle.text = movie.title
        releaseDate.text = releaseDateFormatted(movie.release_date)
        let genreList = Genre_list(genre_ids: movie.genre_ids).printGenres()
        genres.text = genreList
        overview.text = movie.overview
        whereToWatch.text = "Where to watch: "
        
        let preUrl = "https://image.tmdb.org/t/p/w780/"
        let url = URL.init(string: preUrl+movie.backdrop_path)
        self.backdrop.kf.indicatorType = .activity
        self.backdrop.kf.setImage(with: url)
        setupViewHierarchy()
        setupConstraints()
    }
    
    func setupStreamProviders(stream: StreamProviders){
        streamProvider.text = stream.results.printStreamName()
        addSubview(streamProvider)
        
        streamProvider.topAnchor.constraint(equalTo: whereToWatch.bottomAnchor, constant: 20).isActive = true
        streamProvider.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        streamProvider.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    func setupEmptyStreamProviders(string: String){
        streamProvider.text = string
        addSubview(streamProvider)
        
        streamProvider.topAnchor.constraint(equalTo: whereToWatch.bottomAnchor, constant: 20).isActive = true
        streamProvider.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        streamProvider.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }

    func setupViewHierarchy(){
        addSubview(backdrop)
        addSubview(movieTitle)
        addSubview(releaseDate)
        addSubview(genres)
        addSubview(overview)
        addSubview(whereToWatch)
        addSubview(favoriteButton)
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
            releaseDate.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            genres.topAnchor.constraint(equalTo: releaseDate.bottomAnchor, constant: 20),
            genres.leadingAnchor.constraint(equalTo: leadingAnchor),
            genres.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            overview.topAnchor.constraint(equalTo: genres.bottomAnchor, constant: 20),
            overview.leadingAnchor.constraint(equalTo: leadingAnchor),
            overview.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            whereToWatch.topAnchor.constraint(equalTo: overview.bottomAnchor, constant: 20),
            whereToWatch.leadingAnchor.constraint(equalTo: leadingAnchor),
            //whereToWatch.trailingAnchor.constraint(equalTo: trailingAnchor)
            
            favoriteButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            favoriteButton.topAnchor.constraint(equalTo: whereToWatch.bottomAnchor, constant: 80),
            favoriteButton.heightAnchor.constraint(equalToConstant: 60),
            favoriteButton.widthAnchor.constraint(equalToConstant: 230)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func releaseDateFormatted(_ string: String) -> String {
        let startIndex = string.index(string.startIndex, offsetBy: 4)
        let formated = String(string[..<startIndex])
        return formated
    }
}
