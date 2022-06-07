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
        imagem.translatesAutoresizingMaskIntoConstraints = false
        return imagem
    }()
    
    let movieTitle: UILabel = {
        let title: UILabel = UILabel()
        title.font.withSize(18)
        title.textAlignment = .center
        title.numberOfLines = 2
        title.backgroundColor = .gray.withAlphaComponent(0.5)
        
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    func setupCell(moviePoster: URL?, title: String){
        self.moviePoster.kf.setImage(with: moviePoster)
        self.movieTitle.text = title
        setupViewHierarchy()
    }
    
    func setupViewHierarchy(){
        addSubview(moviePoster)
        addSubview(movieTitle)
    }
    
    func setupConstraints(){
        moviePoster.topAnchor.constraint(equalTo: topAnchor)
        moviePoster.leadingAnchor.constraint(equalTo: leadingAnchor)
        moviePoster.trailingAnchor.constraint(equalTo: trailingAnchor)
        moviePoster.bottomAnchor.constraint(equalTo: bottomAnchor)
        
        
    }
    
}
