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
    
    let tab = TabViewController()
    
    @IBAction func register(_ sender: UIButton) {
        guard let email = email.text else { return }
        guard let password = password.text else { return }
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let e = error {
                print(e.localizedDescription)
            } else {
                self.tab.modalPresentationStyle = .fullScreen
                self.navigationController?.present(self.tab, animated: true, completion: nil)
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
}
