//
//  StreamData.swift
//  MyMovies
//
//  Created by Daniel de Andrade Souza on 30/06/22.
//

import Foundation

struct streamProviders: Codable {
    let id: Int
    let results: BR
}

struct BR: Codable {
    let flatrate: [Stream]
}

struct Stream: Codable {
    let logo_path: String
    let provider_name: String
}
