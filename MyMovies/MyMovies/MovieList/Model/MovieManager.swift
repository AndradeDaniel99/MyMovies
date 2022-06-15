//
//  MovieManager.swift
//  MyMovies
//
//  Created by Daniel de Andrade Souza on 07/06/22.
//

import Foundation

protocol MovieManagerDelegate: AnyObject {
    func updateMovies(movie: [Movie])
    func didFailWithError(error: Error)
}

class MovieManager {
    
    weak var delegate: MovieManagerDelegate?
    
    let url = "https://imdb-api.com/API/AdvancedSearch/k_4mjiwsfg?groups=top_100"
    let paginationParam: String = String(1)
    let params = "&count=15&start="
    
    func fetchMovie(_ pagination: String = String(1)){
        let completeUrl = url+params+pagination
        performRequest(with: completeUrl)
    }
    
    func performRequest(with urlString: String){
        // 1. Create a URL
        if let url = URL(string: urlString){
            // 2. Create a URLSession
            let session = URLSession(configuration: .default)
            
            // 3. Give the session a task
            let task = session.dataTask(with: url) { data, response, error in
                if error  != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let movie = self.parseJSON(safeData){
                        self.delegate?.updateMovies(movie: movie.results)
                    }
                }
            }
            
            // 4. Start the task
            task.resume()
        }
    }
    
    func parseJSON(_ movieData: Data) -> MovieData? {
        let decoder = JSONDecoder()
        
        do {
            let decodeData = try decoder.decode(MovieData.self, from: movieData)
            let movieData = MovieData(results: decodeData.results)
            return movieData
        } catch  {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
