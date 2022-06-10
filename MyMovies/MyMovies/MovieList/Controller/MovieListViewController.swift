//
//  ViewController.swift
//  MyMovies
//
//  Created by Daniel de Andrade Souza on 03/06/22.
//

import UIKit

class MovieListViewController: UIViewController {

    var myCollectionView:UICollectionView?
    
    var movies: [Movie] = [Movie(title: "teste", image: "teste")]
    
    var movieManager = MovieManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieManager.delegate = self
        movieManager.fetchMovie()
        
        
        view.backgroundColor = .white
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 120, height: 200)
        
        myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        myCollectionView?.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
        myCollectionView?.backgroundColor = .white
        myCollectionView?.dataSource = self
        myCollectionView?.delegate = self
        view.addSubview(myCollectionView ?? UICollectionView())
        adicionarConstraints()
        
    }
    
    
    func adicionarConstraints(){
        myCollectionView?.translatesAutoresizingMaskIntoConstraints = false
        myCollectionView?.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        myCollectionView?.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        myCollectionView?.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        myCollectionView?.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    
}

extension MovieListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let myCell: MovieCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        myCell.setupCell(moviePoster: movies[indexPath.item].image,title: movies[indexPath.item].title)
        
        return myCell
    }
}

extension MovieListViewController: UICollectionViewDelegate {
 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       print("User tapped on item \(indexPath.row)")
    }
}


extension MovieListViewController: MovieManagerDelegate {
    
    func didUpdateMovie(_ movieManager: MovieManager, movie: [Movie]) {
        DispatchQueue.main.async {
            self.movies = movie
            self.myCollectionView?.reloadData()
            print(self.movies[0].title)
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

