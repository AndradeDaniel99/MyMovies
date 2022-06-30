//
//  SelectedMovieViewController.swift
//  MyMovies
//
//  Created by Daniel de Andrade Souza on 30/06/22.
//

import UIKit

class SelectedMovieViewController: UIViewController {

    let selectedMovieView = SelectedMovieView()
    
    let streamManager = StreamManager()
    
    var streamProviders: [Region] = []
    
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
        streamManager.fetchStream(movie.id)
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
            selectedMovieView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            selectedMovieView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            selectedMovieView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            selectedMovieView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }

}


// MARK: - StreamManagerDelegate

extension SelectedMovieViewController: StreamManagerDelegate {
    func updateStream(stream: StreamProviders) {
        DispatchQueue.main.async {
            self.streamProviders.append(stream.results)
            print(stream.results.BR[0].provider_name)
        }
    }
    
    func streamdidFailWithError(error: Error) {
        print(error)
    }
}
