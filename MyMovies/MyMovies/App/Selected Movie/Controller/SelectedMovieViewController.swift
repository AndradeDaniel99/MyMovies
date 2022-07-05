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
    
    let movie: Movie
    
    let viewModel = SelectedMovieViewModel()
    
    
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
        viewModel.delegate = self
        viewModel.fetchStream()
        viewModel.fetchTrailer()
        setupMovieView()
    }
    
    // MARK: - Methods
    
    func setupMovieView(){
        selectedMovieView.backgroundColor = .white
        selectedMovieView.clipsToBounds = true
        selectedMovieView.favoriteButton.addTarget(self, action: #selector(self.favButtonTapped), for: .touchUpInside)
        selectedMovieView.setupView(movie: movie)
        scroll.addSubview(selectedMovieView)
        scroll.isScrollEnabled = true
        
        view.addSubview(scroll)
       setupConstraints()
    }
    
    @objc func favButtonTapped() {
        print(movie.id)
        self.viewModel.favoritesDelegate?.addFavorite(movie: movie)
        navigationController?.popViewController(animated: false)
    }
    
    func setupTrailer(key: String){
        let baseURL = "https://www.youtube.com/embed/"
        guard let url = URL(string: baseURL+key) else { return }
        selectedMovieView.trailer.load(URLRequest(url: url))
    }
    
    func setupConstraints(){
        selectedMovieView.translatesAutoresizingMaskIntoConstraints = false
        scroll.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            scroll.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scroll.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scroll.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scroll.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            selectedMovieView.topAnchor.constraint(equalTo: scroll.topAnchor),
            selectedMovieView.bottomAnchor.constraint(equalTo: scroll.layoutMarginsGuide.bottomAnchor),
            selectedMovieView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            selectedMovieView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        
        scroll.contentSize = CGSize(width: selectedMovieView.frame.width, height: selectedMovieView.frame.height)
        scroll.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: selectedMovieView.frame.height + 800, right: 0)
    }
    
    
}

