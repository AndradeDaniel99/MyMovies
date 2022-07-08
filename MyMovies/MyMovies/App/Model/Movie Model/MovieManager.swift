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

class MovieManager {
    
    weak var delegate: MovieManagerDelegate?
    
    // trending movies of the week in tmdb API
    let movieurl = "https://api.themoviedb.org/3/trending/movie/week?api_key=807c1d1c3c58e1ef234880e23ac77137&page="
    
    func fetchMovie(_ page: String = String(1)){
        let completeUrl = movieurl+page
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
    
    
    func fetchImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        KingfisherManager.shared.retrieveImage(with: url) { result in
            // Do something with `result`
            switch result {
            case let .success(retrieveImageResult):
                let image = retrieveImageResult.image
                completion(image)

            case let .failure(error):
                print("Error: \(error.localizedDescription)")
                completion(nil)
            }
        }
    }
}
