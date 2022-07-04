//
//  TrailerWebViewController.swift
//  MyMovies
//
//  Created by Daniel de Andrade Souza on 04/07/22.
//

import UIKit
import WebKit

class TrailerWebViewController: UIViewController {

    let webView = WKWebView()
    
    let movieID: String
    
    var trailerKey: String?
    
    let trailerManager = TrailerManager()
    
    init(movieID: String) {
        self.movieID = movieID
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trailerManager.delegate = self
        trailerManager.fetchTrailer(movieID: movieID)
        setupWebView(trailerKey: trailerKey ?? "Rf8LAYJSOL8")
    }
    
    func setupWebView(trailerKey: String){
        view.addSubview(webView)
        print(trailerKey + " ue")
        let baseURL = "https://www.youtube.com/embed/"
        guard let url = URL(string: baseURL+trailerKey) else { return }
        webView.load(URLRequest(url: url))
        setupConstraints()
    }
    
    func setupConstraints(){
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 80).isActive = true
        webView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        webView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
    }

}

extension TrailerWebViewController: TrailerManagerDelegate {
    
    func updateTrailer(trailer: [Trailer]) {
        var trailerKey: String = ""
        for i in 0..<trailer.count {
            if trailer[i].type == "Trailer" {
                trailerKey = trailer[i].key
                break
            }
        }
        print(trailerKey + " teste")
        self.trailerKey = trailerKey
//        DispatchQueue.main.async {
//
//        }
    }
    
    func trailerDidFailWithError(error: Error) {
        print(error)
    }
}
