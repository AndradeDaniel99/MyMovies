//
//  RegisterViewController.swift
//  MyMovies
//
//  Created by Daniel de Andrade Souza on 16/07/22.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    @IBAction func backButton(_ sender: UIButton) {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    let tab = TabViewController()
    
    @IBAction func register(_ sender: UIButton) {
        guard let email = email.text else { return }
        guard let password = password.text else { return }
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let e = error {
                print(e.localizedDescription)
            } else {
                self.tab.navigationItem.setHidesBackButton(true, animated: true)
                self.navigationController?.pushViewController(self.tab, animated: true)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
