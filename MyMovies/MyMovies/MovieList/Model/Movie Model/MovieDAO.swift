//
//  MovieDAO.swift
//  MyMovies
//
//  Created by Daniel de Andrade Souza on 29/06/22.
//

import Foundation


class MovieDAO {
    
    let defaults = UserDefaults.standard
    
    func save(_ movies: [Movie]) {
        guard let path = recoverPath() else { return }
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: movies, requiringSecureCoding: false)
            try data.write(to: path)
        } catch {
            print(String(describing: error))
        }
    }
    
    func recovery() -> [Movie] {
        guard let path = recoverPath() else { return [] }
        do {
            let data = try Data(contentsOf: path)
            guard let savedMovies = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [Movie] else { return [] }
            return savedMovies
        } catch {
            print(String(describing: error))
            return []
        }
    }
    
//    func delete(){
//        defaults.removeObject(forKey: "favoritedMovies")
//    }
    
    func recoverPath() -> URL? {
        guard let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let path = directory.appendingPathComponent("myMovies")
        return path
    }
}
