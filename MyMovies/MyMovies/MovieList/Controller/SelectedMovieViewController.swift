//
//  SelectedMovieViewController.swift
//  MyMovies
//
//  Created by Daniel de Andrade Souza on 30/06/22.
//

import UIKit

class SelectedMovieViewController: UIViewController {
    
    // MARK: - Atributes
    
    let scroll = UIScrollView()
    
    let selectedMovieView = SelectedMovieView()
    
    let streamManager = StreamManager()
    
    let trailerManager = TrailerManager()
    
    let movie: Movie
    
    var favoritesDelegate: FavoritesDelegate?
    
    // MARK: - Constructors
    
    init(movie: Movie, hideFavButton: Bool) {
        self.movie = movie
        self.selectedMovieView.favoriteButton.isHidden = hideFavButton
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        streamManager.delegate = self
        streamManager.fetchStream(movie.id)
        trailerManager.delegate = self
        trailerManager.fetchTrailer(movieID: String(movie.id))
        setupMovieView()
    }
    
    // MARK: - Methods
    
    func setupMovieView(){
        selectedMovieView.backgroundColor = .white
        selectedMovieView.setupView(movie: movie)
        selectedMovieView.clipsToBounds = true
        selectedMovieView.favoriteButton.addTarget(self, action: #selector(self.favButtonTapped), for: .touchUpInside)
        
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
    
    @objc func favButtonTapped() {
        print(movie.id)
        self.favoritesDelegate?.addFavorite(movie: movie)
        navigationController?.popViewController(animated: false)
    }
    
    func setupTrailer(key: String){
        let baseURL = "https://www.youtube.com/embed/"
        guard let url = URL(string: baseURL+key) else { return }
        selectedMovieView.trailer.load(URLRequest(url: url))
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

// MARK: - TrailerManagerDelegate

extension SelectedMovieViewController: TrailerManagerDelegate {
    
    func updateTrailer(trailer: [Trailer]) {
        var trailerKey: String = ""
        for i in 0..<trailer.count {
            if trailer[i].type == "Trailer" {
                trailerKey = trailer[i].key
                break
            }
        }
        DispatchQueue.main.async {
            self.setupTrailer(key: trailerKey)
        }
    }
    
    func trailerDidFailWithError(error: Error) {
        //print(error)
    }
}
