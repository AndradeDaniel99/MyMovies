//
//  SelectedMovieViewController.swift
//  MyMovies
//
//  Created by Daniel de Andrade Souza on 30/06/22.
//

import UIKit

class SelectedMovieViewController: UIViewController {

    let selectedMovieView = SelectedMovieView()
    
    let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMovieView()
    }
    
    func setupMovieView(){
        selectedMovieView.backgroundColor = .green
        selectedMovieView.setupView(movie: movie)
        view.addSubview(selectedMovieView)
       setupConstraints()
        
    }
    
    func setupConstraints(){
        selectedMovieView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            selectedMovieView.topAnchor.constraint(equalTo: view.topAnchor),
            selectedMovieView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            selectedMovieView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            selectedMovieView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }

}
