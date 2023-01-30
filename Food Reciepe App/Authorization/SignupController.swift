//
//  SignupController.swift
//  Food Reciepe App
//
//  Created by Ashi on 1/5/23.
//  Copyright © 2023 Ashi. All rights reserved.
//

import UIKit
import Firebase

class SignupController: UIViewController {
    
    
    var signUpView: SignupView!
    var defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView(){
        let mainView = SignupView(frame: self.view.frame)
        self.signUpView = mainView
        self.signUpView.submitAction = submitPressed
        self.signUpView.cancelAction = cancelPressed
        view.addSubview(signUpView)
    }
    
    func submitPressed(){
        guard let email = signUpView.emailTextField.text else { return }
        guard let password = signUpView.passwordTextField.text else { return }
       
        
        Auth.auth().createUser(withEmail: email, password: password ) { (result, err) in
            
            if let err = err {
                print(err.localizedDescription)
            }
            else {
                guard let uid = result?.user.uid else { return }
                self.defaults.set(false, forKey: "UserLoggedIn")
                print("Successfully Created a User", uid)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    func cancelPressed(){
      dismiss(animated: true, completion: nil)
        
    }
    
}
