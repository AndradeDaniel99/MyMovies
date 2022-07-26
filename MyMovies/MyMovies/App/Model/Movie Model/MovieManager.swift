//
//  MovieManager.swift
//  MyMovies
//
//  Created by Daniel de Andrade Souza on 07/06/22.
//

import Foundation
import Kingfisher

protocol MovieManagerDelegate: AnyObject {
    func updateMovies(movie: [Movie])
    func didFailWithError(error: Error)
}

protocol MovieManaging {
    var delegate: MovieManagerDelegate? { get set }
    
    func fetchMovie(_ page: String, completion: @escaping ([Movie]) -> Void)
}

class MovieManager: MovieManaging {
    
    weak var delegate: MovieManagerDelegate?
    
    // trending movies of the week in tmdb API
    let movieurl = "https://api.themoviedb.org/3/trending/movie/week?api_key=807c1d1c3c58e1ef234880e23ac77137&page="
    
    func fetchMovie(_ page: String = String(1), completion: @escaping ([Movie]) -> Void) {
        let completeUrl = movieurl+page
        performRequest(with: completeUrl, completion: completion)
    }
    
    private func performRequest(with urlString: String, completion: @escaping ([Movie]) -> Void){
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
                        completion(movie.results)
                    }
                }
            }
            
            // 4. Start the task
            task.resume()
        }
    }
    
    private func parseJSON(_ movieData: Data) -> MovieData? {
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
