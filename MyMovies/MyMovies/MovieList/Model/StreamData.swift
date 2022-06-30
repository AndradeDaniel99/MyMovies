//
//  StreamData.swift
//  MyMovies
//
//  Created by Daniel de Andrade Souza on 30/06/22.
//

import Foundation

struct StreamProviders: Codable {
    let results: BR
    
    init(results: BR){
        self.results = results
    }
}

struct BR: Codable {
    let flatrate: [Stream]
    
    func printStreamName() -> String {
        var string = ""
        for i in 0..<flatrate.count {
            string.append("\(flatrate[i].provider_name), ")
        }
        string.removeLast()
        string.removeLast()
        return string
    }
}

struct Stream: Codable {
    let logo_path: String
    let provider_name: String
    
    
}
