//
//  MovieManager.swift
//  MyMovies
//
//  Created by Daniel de Andrade Souza on 07/06/22.
//

import Foundation

struct MovieManager {
    
    let url = "https://imdb-api.com/en/API/MostPopularMovies/k_4mjiwsfg"
    
    func fetchMovie(){
        performRequest(urlString: url)
    }
    
    func performRequest(urlString: String){
        
    }
    
}
