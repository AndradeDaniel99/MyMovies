//
//  MovieData.swift
//  MyMovies
//
//  Created by Daniel de Andrade Souza on 08/06/22.
//

import UIKit
import SwiftUI

struct MovieData: Decodable {
    let results: [Movie]
    
    init(results: [Movie]){
        self.results = results
    }
}

struct Movie: Decodable {
    let id: Int
    let title: String
    let release_date: String // "2022-05-04"
    let genre_ids: [Int] // 14, 15, 16
    let overview: String // short plot of the movie
    let backdrop_path: String // "/wcKFYIiVDvRURrzglV9kGu7fpfY.jpg"
    let poster_path: String
    
    
    func details() -> String {
        let details: String = """
                            
                            Overview:
                            \(overview)
                            
                            Genres:
                            
                            """
        return details
    }
}

struct Genre_list {
    var genre_names: [String] = []
    let genre_ids: [Int]
    init(genre_ids: [Int]) {
        self.genre_ids = genre_ids
    }
    mutating func addGenre(){
        for i in 0..<genre_ids.count {
            switch genre_ids[i] {
            case 28:
                genre_names.append("Action")
            case 12:
                genre_names.append("Adventure")
            case 16:
                genre_names.append("Animation")
            case 35:
                genre_names.append("Comedy")
            case 80:
                genre_names.append("Crime")
            case 99:
                genre_names.append("Documentary")
            case 18:
                genre_names.append("Drama")
            case 10751:
                genre_names.append("Family")
            case 14:
                genre_names.append("Fantasy")
            case 36:
                genre_names.append("History")
            case 27:
                genre_names.append("Horror")
            case 10402:
                genre_names.append("Music")
            case 9648:
                genre_names.append("Mystery")
            case 10749:
                genre_names.append("Romance")
            case 878:
                genre_names.append("Science Fiction")
            case 10770:
                genre_names.append("TV Movie")
            case 53:
                genre_names.append("Thriller")
            case 10752:
                genre_names.append("War")
            case 37:
                genre_names.append("Western")
            default:
                genre_names.append("No genre")
            }
        }
    }
    
    func printGenres()-> String {
        var genres = ""
        for i in 0..<genre_names.count {
            genres.append(genre_names[i]+", ")
        }
        genres.removeLast()
        genres.removeLast()
        return genres
    }
    
    
}
