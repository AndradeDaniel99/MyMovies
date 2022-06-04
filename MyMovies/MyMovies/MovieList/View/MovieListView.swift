//
//  MovieListView.swift
//  MyMovies
//
//  Created by Daniel de Andrade Souza on 03/06/22.
//

import UIKit

class MovieListView: UIView {
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        addSubViews()
        constrainthellolabel()
        constraintnamelabel()
    }
    
    private lazy var hellolabel: UILabel = {
        let label = UILabel()
        label.text = "hello world"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var namelabel: UILabel = {
        let label = UILabel()
        label.text = "{Daniel de Andrade}"
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private func addSubViews(){
        addSubview(hellolabel)
        addSubview(namelabel)
    }
    
    private func constrainthellolabel(){
        let constraint = [
            hellolabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            hellolabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        
        constraint.forEach { item in
            item.isActive = true
        }
    }
    
    private func constraintnamelabel(){
        let constraint = [
            namelabel.topAnchor.constraint(equalTo: hellolabel.bottomAnchor, constant: 12),
            namelabel.centerXAnchor.constraint(equalTo: hellolabel.centerXAnchor)
        ]
        
        constraint.forEach { item in
            item.isActive = true
        }
    }
    
    
}
