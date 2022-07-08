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

    var myCollectionView = MovieCollectionView()
    
    weak var favoritesDelegate: FavoritesDelegate?
    
    var isLoading = false
    
    var loadingView: LoadingReusableView?
    
    var viewModel = MovieListViewModel()
    
    // MARK: - view lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Trending Movies"
        view.backgroundColor = .white
        viewModel.delegate = self
        viewModel.fetchMovies()
        setupCollectionView()
    }
    
    // MARK: - Methods
    
    func setupCollectionView(){
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        view.addSubview(myCollectionView)
        setupviewsConstraints()
    }
    
    func setupviewsConstraints(){
        myCollectionView.translatesAutoresizingMaskIntoConstraints = false
        myCollectionView.topAnchor.constraint(equalTo:  view.topAnchor).isActive = true
        myCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        myCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        myCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    @objc func showAlert(_ gesture: UILongPressGestureRecognizer){
        if gesture.state == .began {
            guard let cell = gesture.view as? UICollectionViewCell else { return }
            guard let indexPath = myCollectionView.indexPath(for: cell) else { return }
            let movie = viewModel.movies[indexPath.item]
            
            showSelectedMovieAlert(movie, handler: { alert in
                self.favoritesDelegate?.addFavorite(movie: movie)
            })
        }
    }
    
    func showSelectedMovieAlert(_ movie: Movie, handler: @escaping (UIAlertAction) -> Void){
        let title = movie.title
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.left
        
        let genre_list = Genre_list(genre_ids: movie.genreIds)
        let details = movie.details()+genre_list.printGenres()
        
        let attributedMessageText = NSMutableAttributedString(
            string: details,
            attributes: [
                NSAttributedString.Key.paragraphStyle: paragraphStyle,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15.0)
            ]
        )
        
        alert.setValue(attributedMessageText, forKey: "attributedMessage")
        
        let backButton = UIAlertAction(title: "Back", style: .cancel)
        alert.addAction(backButton)
        
        let favoriteButton = UIAlertAction(title: "Add favorite", style: .destructive, handler: handler)
        alert.addAction(favoriteButton)
        
        present(alert, animated: true, completion: nil)
    }

}


// MARK: - UICollectionViewDataSource

extension MovieListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(showAlert(_:)))
        let movie = viewModel.movies[indexPath.item]
        
        myCell.setupCell(posterUrl: movie.posterPath)
        myCell.addGestureRecognizer(longPress)
        
        return myCell
    }
}

// MARK: - UICollectionViewDelegate

extension MovieListViewController: UICollectionViewDelegate {
 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = viewModel.movies[indexPath.item]
        let selectedMovieViewController = SelectedMovieViewController(movie: movie, hideFavButton: false)
        
        selectedMovieViewController.viewModel.favoritesDelegate = self.favoritesDelegate
        navigationController?.pushViewController(selectedMovieViewController, animated: false)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if(scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)){
            viewModel.page += 1
            viewModel.fetchMovies()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let index = viewModel.movies.count - 5
        if indexPath.item == index {
            viewModel.page += 1
            viewModel.fetchMovies()
        }
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
