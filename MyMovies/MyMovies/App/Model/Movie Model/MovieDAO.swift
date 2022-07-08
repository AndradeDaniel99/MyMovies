//
//  MovieDAO.swift
//  MyMovies
//
//  Created by Daniel de Andrade Souza on 29/06/22.
//

import Foundation


class MovieDAO {
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("movies.plist")
    
    weak var delegate: FavoriteMoviesViewModel?
    
    func saveMovies(){
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(delegate?.myMovies)
            if let dataFilePath = dataFilePath {
                try data.write(to: dataFilePath)
            }
        } catch  {
            print(error.localizedDescription)
        }
    }
    
    func loadMovies(){
        let decoder = PropertyListDecoder()
        do {
            if let dataFilePath = dataFilePath {
                let data = try Data(contentsOf: dataFilePath)
                delegate?.myMovies = try decoder.decode([Movie].self, from: data)
            }
        } catch  {
            print(error.localizedDescription)
        }
    }
    
    func checkDoubledMovies(movie: Movie){
        var count = 0
        if let delegate = delegate {
            for myMovie in delegate.myMovies {
                if movie == myMovie {
                    count += 1
                }
            }
        }
        
        if count == 0 {
            delegate?.myMovies.append(movie)
            saveMovies()
        }
    }
}
