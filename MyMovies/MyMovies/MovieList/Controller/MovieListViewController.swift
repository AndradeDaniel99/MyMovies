//
//  ViewController.swift
//  MyMovies
//
//  Created by Daniel de Andrade Souza on 03/06/22.
//

import UIKit

class MovieListViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        buildView()
    }

    private func buildView(){
        view = MovieListView()
    }

}
