//
//  StreamData.swift
//  MyMovies
//
//  Created by Daniel de Andrade Souza on 30/06/22.
//

import Foundation

struct StreamProviders: Codable {
    let results: Region
    
    init(results: Region){
        self.results = results
    }
}

struct Region: Codable {
    let BR: [Stream]
    
//    func printStreamName() -> String {
//        var string = ""
//        for i in 0..<BR.count {
//            string.append("\(BR[i].provider_name), ")
//        }
//        string.removeLast()
//        string.removeLast()
//        return string
//    }
}

struct Stream: Codable {
    let logo_path: String
    let provider_name: String
    
    
}
