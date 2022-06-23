//
//  TableViewCell.swift
//  MyMovies
//
//  Created by Daniel de Andrade Souza on 23/06/22.
//

import UIKit
import Kingfisher

class TableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    let moviePoster: UIImageView = {
        let imagem:UIImageView = UIImageView()
        imagem.contentMode = .scaleToFill
        imagem.translatesAutoresizingMaskIntoConstraints = false
        return imagem
    }()
    
    let movieTitle: UILabel = {
        let title: UILabel = UILabel()
        title.font.withSize(18)
        title.textAlignment = .center
        title.numberOfLines = 2
        title.textColor = .black
        title.backgroundColor = .blue.withAlphaComponent(0.5)

        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    func setupCell(posterUrl: String, title: String){
        self.movieTitle.text = title
        let processor = DownsamplingImageProcessor(size: CGSize(width: 300, height: 445))
        let url = URL.init(string: posterUrl)
        self.moviePoster.kf.indicatorType = .activity
        self.moviePoster.kf.setImage(with: url, options: [.processor(processor)])
        setupViewHierarchy()
        setupConstraints()
        configureView()
    }
    
    func setupViewHierarchy(){
        addSubview(moviePoster)
        addSubview(movieTitle)
    }
    
    func setupConstraints(){
        moviePoster.topAnchor.constraint(equalTo: topAnchor).isActive = true
        moviePoster.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        moviePoster.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        moviePoster.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        movieTitle.topAnchor.constraint(equalTo: topAnchor).isActive = true
        movieTitle.leadingAnchor.constraint(equalTo: moviePoster.trailingAnchor, constant: 5).isActive = true
        movieTitle.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        movieTitle.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    func configureView(){
        backgroundColor = .white
    }

}
