//
//  MovieData.swift
//  MyMovies
//
//  Created by Daniel de Andrade Souza on 08/06/22.
//

import Foundation


struct MovieData: Decodable {
    let items: [Movie]
    
    init(items: [Movie]){
        self.items = items
    }
}

struct Movie: Decodable {
    let title: String
    let image: String
}

