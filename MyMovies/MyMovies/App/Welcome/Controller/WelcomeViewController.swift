//
//  WelcomeViewController.swift
//  MyMovies
//
//  Created by Daniel de Andrade Souza on 16/07/22.
//

import UIKit

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var label: UILabel!
    
    let registerViewControler = RegisterViewController()
    let loginViewController = LoginViewController()
    
    override func present(_ viewControllerToPresent: UIViewController,
                            animated flag: Bool,
                            completion: (() -> Void)? = nil) {
        viewControllerToPresent.modalPresentationStyle = .fullScreen
        super.present(viewControllerToPresent, animated: flag, completion: completion)
      }
    
    @IBAction func register(_ sender: UIButton) {
        let navVC = UINavigationController(rootViewController: registerViewControler)
        present(navVC, animated: true, completion: nil)
    }
    
    @IBAction func login(_ sender: UIButton) {
        let navVC = UINavigationController(rootViewController: loginViewController)
        present(navVC, animated: true, completion: nil)
        
    }
}
