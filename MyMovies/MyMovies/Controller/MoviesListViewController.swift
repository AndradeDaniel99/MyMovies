//
//  ViewController.swift
//  MyMovies
//
//  Created by Daniel de Andrade Souza on 01/06/22.
//

import UIKit

class MoviesListViewController: UIViewController {

    
    convenience init() {
        self.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    var movieListView: MovieListView
    
    override func loadView() {
        view = movieListView
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("the view loaded")
    }


}

