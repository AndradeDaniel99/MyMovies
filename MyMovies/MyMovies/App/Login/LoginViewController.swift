//
//  LoginViewController.swift
//  MyMovies
//
//  Created by Daniel de Andrade Souza on 16/07/22.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    

    @IBAction func backButton(_ sender: UIButton) {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    let tab = TabViewController()
    
    @IBAction func login(_ sender: UIButton) {
        if let email = email.text, let password = password.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e.localizedDescription)
                } else {
                    self.tab.navigationItem.setHidesBackButton(true, animated: true)
                    self.navigationController?.pushViewController(self.tab, animated: true)
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
