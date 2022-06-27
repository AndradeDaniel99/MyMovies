//
//  MovieData.swift
//  MyMovies
//
//  Created by Daniel de Andrade Souza on 08/06/22.
//

import UIKit

struct MovieData: Decodable {
    let results: [Movie]
    
    init(results: [Movie]){
        self.results = results
    }
}

struct Movie: Decodable {
    let id: Int
    let title: String
    let release_date: String // "2022-05-04"
    let genre_ids: [Int] // 14, 15, 16
    let overview: String // short plot of the movie
    let backdrop_path: String // "/wcKFYIiVDvRURrzglV9kGu7fpfY.jpg"
    let poster_path: String
    
    
    func details() -> String {
        let details: String = """
                            
                            Overview:
                            \(overview)
                            
                            """
        return details
    }
}
