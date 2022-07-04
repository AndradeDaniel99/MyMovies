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
    
    let trailerKey: String
    
    init(key: String) {
        self.trailerKey = key
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
    }
    func setupWebView(){
        view.addSubview(webView)
        let baseURL = "https://www.youtube.com/embed/"
        guard let url = URL(string: baseURL+trailerKey) else { return }
        webView.load(URLRequest(url: url))
    }

}
