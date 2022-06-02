//
//  Viewcode.swift
//  MyMovies
//
//  Created by Daniel de Andrade Souza on 02/06/22.
//

import Foundation

protocol ViewCode {
    func setupViewHierarchy()
    func setupConstraints()
    func configureViews()
    func setupView()
}

extension ViewCode {
    func setupView() {
        setupViewHierarchy()
        setupConstraints()
        configureViews()
    }
}
