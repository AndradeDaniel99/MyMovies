//
//  TrailerData.swift
//  MyMovies
//
//  Created by Daniel de Andrade Souza on 04/07/22.
//

import Foundation


class TrailerData: Codable {
    let results: [Trailer]
    
    init(results: [Trailer]){
        self.results = results
    }
}

class Trailer: Codable {
    let key: String
    let site: String
    let type: String
}
