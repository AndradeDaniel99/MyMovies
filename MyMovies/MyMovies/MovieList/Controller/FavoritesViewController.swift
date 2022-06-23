//
//  FavoritesViewController.swift
//  MyMovies
//
//  Created by Daniel de Andrade Souza on 15/06/22.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDataSource {
    
    var myMovies: [Movie] = []
    
    var teste = ["1","1","1","1","1"]
    
    let myTableView = UITableView()
    
    override func loadView() {
        super.loadView()
        // Do any additional setup after loading the view.
        title = "My Movies"
        setupTableView()
    }
    
    func setupTableView(){
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        myTableView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight);
        myTableView.dataSource = self
//        myTableView.translatesAutoresizingMaskIntoConstraints = false
//        myTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        myTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
//        myTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//        myTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        myTableView.backgroundColor = .white
        view.addSubview(myTableView)
    }
    
    
    func addFavorite(movie: Movie){
        
        DispatchQueue.main.async {
            self.teste.append(movie.title)
            self.myTableView.reloadData()
            print("item \(movie.title) favorited")
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        teste.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        //cell.textLabel?.text = myMovies[indexPath.row].title
        cell.textLabel?.text = teste[indexPath.row]
        
        return cell
    }
    
}
