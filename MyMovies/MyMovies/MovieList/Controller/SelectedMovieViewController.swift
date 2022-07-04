//
//  SelectedMovieViewController.swift
//  MyMovies
//
//  Created by Daniel de Andrade Souza on 30/06/22.
//

import UIKit

class SelectedMovieViewController: UIViewController {
    
    let scroll = UIScrollView()
    
    let selectedMovieView = SelectedMovieView()
    
    let streamManager = StreamManager()
    
    let movie: Movie
    
    var favoritesDelegate: FavoritesDelegate?
    
    init(movie: Movie, hideFavButton: Bool) {
        self.movie = movie
        self.selectedMovieView.favoriteButton.isHidden = hideFavButton
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        streamManager.delegate = self
        streamManager.fetchStream(movie.id)
        setupMovieView()
    }
    
    func setupMovieView(){
        selectedMovieView.backgroundColor = .white
        selectedMovieView.setupView(movie: movie)
        selectedMovieView.clipsToBounds = true
        selectedMovieView.favoriteButton.addTarget(self, action: #selector(self.buttonClicked), for: .touchUpInside)
        
        scroll.addSubview(selectedMovieView)
        scroll.isScrollEnabled = true
        //scroll.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        view.addSubview(scroll)
       setupConstraints()
    }
    
    func setupConstraints(){
        selectedMovieView.translatesAutoresizingMaskIntoConstraints = false
        scroll.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            scroll.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scroll.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            scroll.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            scroll.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            selectedMovieView.topAnchor.constraint(equalTo: scroll.layoutMarginsGuide.topAnchor),
            selectedMovieView.bottomAnchor.constraint(equalTo: scroll.layoutMarginsGuide.bottomAnchor),
            selectedMovieView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            selectedMovieView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc func buttonClicked() {
        print(movie.id)
        self.favoritesDelegate?.addFavorite(movie: movie)
        navigationController?.popViewController(animated: false)
    }
    
    
}


// MARK: - StreamManagerDelegate

extension SelectedMovieViewController: StreamManagerDelegate {
    func updateStream(stream: StreamProviders) {
        DispatchQueue.main.async {
            self.selectedMovieView.setupStreamProviders(stream: stream)
            //print(stream.results.printStreamName())
        }
    }
    
    func streamdidFailWithError(error: Error) {
        DispatchQueue.main.async {
            self.selectedMovieView.setupEmptyStreamProviders(string: "No streaming available for this movie in your region.")
        }
        //print(error.localizedDescription)
    }
}
