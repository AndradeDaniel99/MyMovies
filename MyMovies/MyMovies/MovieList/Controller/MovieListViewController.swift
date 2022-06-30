//
//  ViewController.swift
//  MyMovies
//
//  Created by Daniel de Andrade Souza on 03/06/22.
//

import UIKit

protocol FavoritesDelegate: AnyObject{
    func addFavorite(movie: Movie)
}

class MovieListViewController: UIViewController {
    
    // MARK: - Atributes

    var myCollectionView:MovieCollectionView?
    
    weak var favoritesDelegate: FavoritesDelegate?
    
    var movies: [Movie] = []
    
    let movieManager = MovieManager()
    
    var page = 1
    
    var isLoading = false
    
    var loadingView: LoadingReusableView?
    
    // MARK: - view lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Trending Movies"
        view.backgroundColor = .white
        movieManager.delegate = self
        movieManager.fetchMovie()
        setupCollectionView()
    }
    
    // MARK: - Methods
    
    func setupCollectionView(){
        let screenWidth = UIScreen.main.bounds.size.width
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 1, bottom: 10, right: 1)
        layout.itemSize = CGSize(width: (screenWidth/3)-1, height: screenWidth/2)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        myCollectionView = MovieCollectionView(frame: self.view.frame, collectionViewLayout: layout)
        myCollectionView?.dataSource = self
        myCollectionView?.delegate = self
        view.addSubview(myCollectionView ?? UICollectionView())
        setupviewsConstraints()
    }
    
    func setupviewsConstraints(){
        myCollectionView?.translatesAutoresizingMaskIntoConstraints = false
        myCollectionView?.topAnchor.constraint(equalTo:  view.topAnchor).isActive = true
        myCollectionView?.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        myCollectionView?.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        myCollectionView?.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    @objc func showDetails(_ gesture: UILongPressGestureRecognizer){
        if gesture.state == .began {
            let cell = gesture.view as! UICollectionViewCell
            guard let indexPath = myCollectionView?.indexPath(for: cell) else { return }
            let movie = movies[indexPath.item]
            MovieDetailsViewController(controller: self).showDetails(movie, handler: { alert in
                self.favoritesDelegate?.addFavorite(movie: movie)
            })
        }
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
        
        myCell.setupCell(posterUrl: movies[indexPath.item].poster_path)
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(showDetails(_:)))
        myCell.addGestureRecognizer(longPress)
        return myCell
    }
}

// MARK: - UICollectionViewDelegate

extension MovieListViewController: UICollectionViewDelegate {
 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let movie = movies[indexPath.item]
        navigationController?.pushViewController(SelectedMovieViewController(movie: movie), animated: false)
        
    }
    
//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        if(scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)-55){
//            pagination+=15
//            movieManager.fetchMovie(String(pagination))
//            }
//    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if(scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)){
            page+=1
            movieManager.fetchMovie(String(page))
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

// MARK: - StreamManagerDelegate

extension MovieListViewController: StreamManagerDelegate {
    func updateStream(stream: BR) {
        
    }
    
    func streamdidFailWithError(error: Error) {
        print(error)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MovieListViewController: UICollectionViewDelegateFlowLayout {
    
    // return the size for the Loading View when it’s time to show it.
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if self.isLoading {
            return CGSize.zero
        } else {
            return CGSize(width: collectionView.bounds.size.width, height: 55)
        }
    }
    
    
    // Set the reusable view in the CollectionView footer

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
                   let loadingFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "loadingresuableviewid", for: indexPath) as! LoadingReusableView
                   loadingView = loadingFooterView
                   loadingView?.backgroundColor = UIColor.clear
                   return loadingFooterView
               }
               return UICollectionReusableView()
    }
    
    
    // start and stop the activityIndicator‘s animation when the footer appears and disappears, respectively.
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
            if elementKind == UICollectionView.elementKindSectionFooter {
                self.loadingView?.activityIndicator.startAnimating()
            }
        }

        func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
            if elementKind == UICollectionView.elementKindSectionFooter {
                self.loadingView?.activityIndicator.stopAnimating()
            }
        }
    
}
