//
//  SelectedMovieViewModel.swift
//  MyMovies
//
//  Created by Daniel de Andrade Souza on 05/07/22.
//

import Foundation


class SelectedMovieViewModel {
    
    // MARK: - Atributes
    
    weak var delegate: SelectedMovieViewController?
    
    let streamManager: StreamManager
    
    let trailerManager: TrailerManager
    
    var favoritesDelegate: FavoritesDelegate?
    
    init(streamManager: StreamManager = StreamManager(), trailerManager: TrailerManager = TrailerManager()){
        self.streamManager = streamManager
        self.trailerManager = trailerManager
        setupDelegates()
    }
    
    // MARK: - Methods
    
    func setupDelegates(){
        streamManager.delegate = self
        trailerManager.delegate = self
    }
    
    func fetchStream(){
        if let delegate = delegate {
            streamManager.fetchStream(delegate.movie.id)
        }
    }
    
    func fetchTrailer(){
        if let delegate = delegate {
            trailerManager.fetchTrailer(movieID: String(delegate.movie.id))
        }
    }
}


// MARK: - StreamManagerDelegate

extension SelectedMovieViewModel: StreamManagerDelegate {
    func updateStream(stream: StreamProviders) {
        DispatchQueue.main.async {
            self.delegate?.selectedMovieView.setupStreamProviders(stream: stream)
        }
    }
    
    func streamdidFailWithError(error: Error) {
        DispatchQueue.main.async {
            self.delegate?.selectedMovieView.setupEmptyStreamProviders(string: "No streaming available for this movie in your region.")
        }
    }
}

// MARK: - TrailerManagerDelegate

extension SelectedMovieViewModel: TrailerManagerDelegate {
    
    func updateTrailer(trailer: [Trailer]) {
        var trailerKey: String = ""
        for i in 0..<trailer.count {
            if trailer[i].type == "Trailer" {
                trailerKey = trailer[i].key
                break
            }
        }
        DispatchQueue.main.async {
            self.delegate?.setupTrailer(key: trailerKey)
        }
    }
    
    func trailerDidFailWithError(error: Error) {
        print(error.localizedDescription)
    }
}
