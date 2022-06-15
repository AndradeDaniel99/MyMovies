//
//  MovieCollectionView.swift
//  MyMovies
//
//  Created by Daniel de Andrade Souza on 15/06/22.
//

import UIKit

class MovieCollectionView: UICollectionView {

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        setupCollectionView()
        adicionarConstraints()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCollectionView() {
        register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
        backgroundColor = UIColor.blue
    }
    
    func adicionarConstraints(){
        guard let superview = superview else { return }
        
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo:  superview.safeAreaLayoutGuide.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor).isActive = true
        leadingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    

}
