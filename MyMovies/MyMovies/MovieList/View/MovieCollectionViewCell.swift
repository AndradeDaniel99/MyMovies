//
//  MovieCollectionViewCell.swift
//  MyMovies
//
//  Created by Daniel de Andrade Souza on 07/06/22.
//

import UIKit
import Kingfisher

class MovieCollectionViewCell: UICollectionViewCell {
    
    let moviePoster: UIImageView = {
        let imagem:UIImageView = UIImageView()
        imagem.contentMode = .scaleToFill
        imagem.translatesAutoresizingMaskIntoConstraints = false
        return imagem
    }()
    
    func setupCell(posterUrl: String){
        let preUrl = "https://image.tmdb.org/t/p/w185/"
        let processor = RoundCornerImageProcessor(cornerRadius: 10)
        let url = URL.init(string: preUrl+posterUrl)
        self.moviePoster.kf.indicatorType = .activity
        self.moviePoster.kf.setImage(with: url, options: [.processor(processor)])
        
        setupViewHierarchy()
        setupConstraints()
        configureView()
    }
    
    func setupViewHierarchy(){
        addSubview(moviePoster)
    }
    
    func setupConstraints(){
        moviePoster.topAnchor.constraint(equalTo: topAnchor, constant: 1).isActive = true
        moviePoster.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 1).isActive = true
        moviePoster.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -1).isActive = true
        moviePoster.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1).isActive = true
    }
    
    func configureView(){
        backgroundColor = .white
    }
}
