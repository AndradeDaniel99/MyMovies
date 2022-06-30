//
//  StreamManager.swift
//  MyMovies
//
//  Created by Daniel de Andrade Souza on 30/06/22.
//

import Foundation

protocol StreamManagerDelegate: AnyObject {
    func updateStream(stream: BR)
    func streamdidFailWithError(error: Error)
}

class StreamManager {
    
    weak var delegate: StreamManagerDelegate?
    
//    let url = "https://imdb-api.com/API/AdvancedSearch/k_4mjiwsfg?groups=top_100"
//    let paginationParam: String = String(1)
//    let params = "&count=15&start="
    
    let baseurl = "https://api.themoviedb.org/3/movie/"
    let finalurl = "/watch/providers?api_key=807c1d1c3c58e1ef234880e23ac77137"
    
    func fetchStream(_ movieID: Int){
        let completeUrl = baseurl+String(movieID)+finalurl
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
                    self.delegate?.streamdidFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let stream = self.parseJSON(safeData){
                        self.delegate?.updateStream(stream: stream.results)
                    }
                }
            }
            
            // 4. Start the task
            task.resume()
        }
    }
    
    func parseJSON(_ streamData: Data) -> StreamProviders? {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(StreamProviders.self, from: streamData)
            let streamProviders = StreamProviders(results: decodeData.results)
            return streamProviders
        } catch  {
            delegate?.streamdidFailWithError(error: error)
            return nil
        }
    }
}
