//
//  TrailerManager.swift
//  MyMovies
//
//  Created by Daniel de Andrade Souza on 04/07/22.
//

import Foundation

protocol TrailerManagerDelegate: AnyObject {
    func updateTrailer(trailer: [Trailer])
    func trailerDidFailWithError(error: Error)
}

class TrailerManager {
    
    weak var delegate: TrailerManagerDelegate?
    
    let baseURL = "https://api.themoviedb.org/3/movie/"
    let finalURL = "/videos?api_key=807c1d1c3c58e1ef234880e23ac77137&language=en-US"
    
    func fetchTrailer(movieID: String){
        let completeUrl = baseURL+movieID+finalURL
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
                    self.delegate?.trailerDidFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let trailer = self.parseJSON(safeData){
                        self.delegate?.updateTrailer(trailer: trailer.results)
                    }
                }
            }
            // 4. Start the task
            task.resume()
        }
    }
    
    func parseJSON(_ trailerData: Data) -> TrailerData? {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(TrailerData.self, from: trailerData)
            let trailerData = TrailerData(results: decodeData.results)
            return trailerData
        } catch  {
            delegate?.trailerDidFailWithError(error: error)
            return nil
        }
    }
    
}
