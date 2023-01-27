//
//  LoginController.swift
//  Food Reciepe App
//
//  Created by Ashi on 1/5/23.
//  Copyright © 2023 Ashi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginController: UIViewController {
    
    var loginView: LoginView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    func setupView(){
        let mainView = LoginView(frame: self.view.frame)
        self.loginView = mainView
        self.loginView.loginAction = loginPressed
        self.loginView.signupAction = signupPressed
        self.view.addSubview(loginView)
        loginView.setAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
    }
    func loginPressed(){
        guard let email = loginView.emailTextField.text else { return }
        guard let password = loginView.passwordTextField.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            
            if let err = error {
                print(err.localizedDescription)
            }
            else {
              
                print("User: \(user?.user) signed in")
                
                
                
                
               let mainviewController = UINavigationController(rootViewController: MainViewController())
                 mainviewController.modalPresentationStyle = .fullScreen
                self.present(mainviewController, animated: true, completion: nil)
                
            }
        }
    }
    
    func signupPressed() {
        let signupController = SignupController()
        signupController.modalPresentationStyle = .fullScreen
        present(signupController, animated: true, completion: nil)
    }
    
}

