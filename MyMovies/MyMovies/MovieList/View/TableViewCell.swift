//
//  TableViewCell.swift
//  MyMovies
//
//  Created by Daniel de Andrade Souza on 23/06/22.
//

import UIKit
import Kingfisher

class TableViewCell: UITableViewCell {

//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    let moviePoster: UIImageView = {
        let imagem:UIImageView = UIImageView()
        imagem.contentMode = .scaleToFill
        imagem.translatesAutoresizingMaskIntoConstraints = false
        imagem.backgroundColor = .white.withAlphaComponent(0.1)
        return imagem
    }()
    
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
    
    let genres: UILabel = {
        let genres: UILabel = UILabel()
        genres.font.withSize(14)
        genres.textAlignment = .left
        genres.numberOfLines = 0
        genres.textColor = .darkGray
        genres.translatesAutoresizingMaskIntoConstraints = false
        return genres
    }()
    
    func setupCell(posterUrl: String, title: String, genres: String){
        self.movieTitle.text = title
        self.genres.text = genres
        let preUrl = "https://image.tmdb.org/t/p/w92/"
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
        addSubview(movieTitle)
        addSubview(genres)
    }
    
    func setupConstraints(){
        let constraints = [
            moviePoster.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            moviePoster.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 3),
            moviePoster.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            moviePoster.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3),
            moviePoster.widthAnchor.constraint(equalToConstant: 92),
            
            movieTitle.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            movieTitle.topAnchor.constraint(equalTo: topAnchor),
            movieTitle.leadingAnchor.constraint(equalTo: moviePoster.trailingAnchor, constant: 20),
            movieTitle.trailingAnchor.constraint(equalTo: trailingAnchor),
            movieTitle.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            genres.topAnchor.constraint(equalTo: movieTitle.centerYAnchor),
            genres.leadingAnchor.constraint(equalTo: moviePoster.trailingAnchor, constant: 20),
            genres.bottomAnchor.constraint(equalTo: moviePoster.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func configureView(){
        backgroundColor = .white
    }

}
