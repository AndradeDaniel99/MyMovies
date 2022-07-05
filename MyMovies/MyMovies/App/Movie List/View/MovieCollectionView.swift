//
//  MovieCollectionView.swift
//  MyMovies
//
//  Created by Daniel de Andrade Souza on 15/06/22.
//

import UIKit

class MovieCollectionView: UICollectionView {

    public init() {
        let screenWidth = UIScreen.main.bounds.size.width
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 1, bottom: 10, right: 1)
        layout.itemSize = CGSize(width: (screenWidth/3)-1, height: screenWidth/2)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0

        super.init(frame: CGRect.zero, collectionViewLayout: layout)
        setupCollectionView()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCollectionView() {
        register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
        let loadingReusableNib = UINib(nibName: "LoadingReusableView", bundle: nil)
        register(loadingReusableNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "loadingresuableviewid")
        backgroundColor = UIColor.white
    }
}
