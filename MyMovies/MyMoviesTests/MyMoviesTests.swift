//
//  MockMovieManager.swift
//  MyMoviesTests
//
//  Created by Daniel de Andrade Souza on 25/07/22.
//

import XCTest
@testable import MyMovies

class MovieListViewModelTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }
    
    func testUpdateMovies() throws {
        let mock = MockMovieManager()
        let viewModel = MovieListViewModel(movieManager: mock)
        let expectation = XCTestExpectation(description: "Expectation")

        
        viewModel.fetchMovies {
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)

        
        XCTAssertEqual(viewModel.movies.count, 1)
    }
    
}
