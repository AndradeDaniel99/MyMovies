//
//  MockMovieManager.swift
//  MyMoviesTests
//
//  Created by Daniel de Andrade Souza on 25/07/22.
//

import Foundation
@testable import MyMovies

class MockMovieManager: MovieManaging {
    var delegate: MovieManagerDelegate?
    
    func fetchMovie(_ page: String, completion: @escaping ([Movie]) -> Void) {
        let movie = Movie(id: 1, title: "Star Wars", releaseDate: "2022", genreIds: [0], overview: "Action movie from George Lucas", backdropPath: "", posterPath: "")
        
        completion([movie])
    }
    
    
}
