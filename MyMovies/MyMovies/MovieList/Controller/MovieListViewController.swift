//
//  ViewController.swift
//  MyMovies
//
//  Created by Daniel de Andrade Souza on 03/06/22.
//

import UIKit
import Kingfisher

class MovieListViewController: UIViewController {
    
    // MARK: - Atributes

    var myCollectionView:UICollectionView?
    
    var movies: [Movie] = []
    
    var movieManager = MovieManager()
    
    var pagination = 1
    
    
    
    // MARK: - view lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieManager.delegate = self
        movieManager.fetchMovie(String(1))
        
        
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
        addConstraints()
        
    }
    
    
    func addConstraints(){
        myCollectionView?.translatesAutoresizingMaskIntoConstraints = false
        myCollectionView?.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        myCollectionView?.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        myCollectionView?.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        myCollectionView?.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    
    
}




// MARK: - UICollectionViewDataSource

extension MovieListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let myCell: MovieCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        let imageUrl = URL.init(string: movies[indexPath.item].image)
        myCell.moviePoster.kf.setImage(with: imageUrl)
        myCell.setupCell(title: movies[indexPath.item].title)
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(showDetails(_:)))
        myCell.addGestureRecognizer(longPress)
        
        return myCell
    }
    
    
    @objc func showDetails(_ gesture: UILongPressGestureRecognizer){
        
        // checagem necessaria para realizar o metodo somente no comeco do gesto
        if gesture.state == .began {
            
            // a gesture view precisa ser tratada como uma celula da tableview,
            // indexpath foi recebido da tableview,
            // refeicao é o objeto refeicao na posicao da celula que foi pressionada
            let cell = gesture.view as! UICollectionViewCell
            guard let indexPath = myCollectionView?.indexPath(for: cell) else { return }
            let movie = movies[indexPath.item]
            
            MovieDetailsViewController(controller: self).showDetails(movie, handler: { alert in
                print("adicionou um favorito")
            })
            
        }
        
    }
    
}


// MARK: - UICollectionViewDelegate

extension MovieListViewController: UICollectionViewDelegate {
 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       print("User tapped on item \(indexPath.row)")
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if(scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)){
            pagination+=15
            movieManager.fetchMovie(String(pagination))
            }
    }
}


// MARK: - MovieManagerDelegate

extension MovieListViewController: MovieManagerDelegate {
    
    func updateMovies(movie: [Movie]) {
        DispatchQueue.main.async {
            self.movies += movie
            self.myCollectionView?.reloadData()
            print(self.movies[0].title)
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

