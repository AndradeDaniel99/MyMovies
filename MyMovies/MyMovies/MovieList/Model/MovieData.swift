//
//  MovieData.swift
//  MyMovies
//
//  Created by Daniel de Andrade Souza on 08/06/22.
//

import Foundation


struct MovieData: Decodable {
    let results: [Movie]
    
    init(results: [Movie]){
        self.results = results
    }
}

struct Movie: Decodable {
    let title: String
    let image: String
//    let description: String // (1999)
//    let runtimeStr: String // 130 min
//    let genres: String // action, drama
//    let plot: String // short plot of the movie
//    let stars: String // leonardo dicaprio, joel santana, tom cruise
    
}

