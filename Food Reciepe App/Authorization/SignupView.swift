//
//  SignupView.swift
//  Food Reciepe App
//
//  Created by Ashi on 1/5/23.
//  Copyright © 2023 Ashi. All rights reserved.
//

import UIKit

class SignupView: UIView {
    
     let backgroundImageView: UIImageView = {
           let iv = UIImageView()
           iv.image = UIImage(named: "Bgimage")
           iv.contentMode = .scaleAspectFill
           return iv
       }()
    
    let nameTextField: UITextField = {
       let tf = UITextField()
        tf.borderStyle = .none
        tf.layer.cornerRadius = 5
        tf.backgroundColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 0.2)
        tf.textColor = UIColor(white: 1, alpha: 0.8)
        
        tf.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        tf.autocorrectionType = .no
        var placeholder = NSMutableAttributedString()
        placeholder = NSMutableAttributedString(attributedString: NSAttributedString(string: "Name", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18), .foregroundColor: UIColor(white: 1, alpha: 0.7) ]))
        tf.attributedPlaceholder = placeholder
        tf.setAnchor(width: 0, height: 40)
        tf.setLeftPaddingPoints(20)
        return tf
        
    }()
    
    let emailTextField: UITextField = {
       let tf = UITextField()
        tf.borderStyle = .none
        tf.layer.cornerRadius = 5
        tf.backgroundColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 0.2)
        tf.textColor = UIColor(white: 1, alpha: 0.8)
        
        tf.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        tf.autocorrectionType = .no
        var placeholder = NSMutableAttributedString()
        placeholder = NSMutableAttributedString(attributedString: NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18), .foregroundColor: UIColor(white: 1, alpha: 0.7) ]))
        tf.attributedPlaceholder = placeholder
        tf.setAnchor(width: 0, height: 40)
        tf.setLeftPaddingPoints(20)
        return tf
        
    }()
    
    let passwordTextField: UITextField = {
       let tf = UITextField()
        tf.borderStyle = .none
        tf.layer.cornerRadius = 5
        tf.backgroundColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 0.2)
        tf.textColor = UIColor(white: 1, alpha: 0.8)
        
        tf.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        tf.autocorrectionType = .no
        var placeholder = NSMutableAttributedString()
        placeholder = NSMutableAttributedString(attributedString: NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18), .foregroundColor: UIColor(white: 1, alpha: 0.7) ]))
        tf.attributedPlaceholder = placeholder
        tf.setAnchor(width: 0, height: 40)
        tf.isSecureTextEntry = true
        tf.setLeftPaddingPoints(20)
        return tf
        
    }()
    
    let conPassTextField: UITextField = {
       let tf = UITextField()
        tf.borderStyle = .none
        tf.layer.cornerRadius = 5
        tf.backgroundColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 0.2)
        tf.textColor = UIColor(white: 1, alpha: 0.8)
        
        tf.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        tf.autocorrectionType = .no
        var placeholder = NSMutableAttributedString()
        placeholder = NSMutableAttributedString(attributedString: NSAttributedString(string: "Confirm Password", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18), .foregroundColor: UIColor(white: 1, alpha: 0.7) ]))
        tf.attributedPlaceholder = placeholder
        tf.setAnchor(width: 0, height: 40)
        tf.isSecureTextEntry = true
        tf.setLeftPaddingPoints(20)
        return tf
        
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton()
        let attributedString = NSMutableAttributedString(attributedString: NSAttributedString(string: "Submit", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .bold), .foregroundColor: UIColor.white]))
        button.setAttributedTitle(attributedString, for: .normal)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 80/255, green: 227/255, blue: 194/255, alpha: 1).cgColor
        button.setAnchor(width: 0, height: 50)
        button.addTarget(self, action: #selector(handleSubmit), for: .touchUpInside)
        return button
        
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton()
        let attributedString = NSMutableAttributedString(attributedString: NSAttributedString(string: "Cancel", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .bold), .foregroundColor: UIColor.white]))
        button.setAttributedTitle(attributedString, for: .normal)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 255/255, green: 151/255, blue: 194/255, alpha: 1).cgColor
        button.setAnchor(width: 0, height: 50)
        button.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        return button
        
    }()
    
    var submitAction: (() -> Void)?
    var cancelAction: (() -> Void)?
    
    func mainStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [nameTextField, emailTextField, passwordTextField,conPassTextField, signUpButton,cancelButton])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        return stackView
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    func setupView(){
        
        let stackView = mainStackView()
        self.addSubview(backgroundImageView)
        addSubview(stackView)
        backgroundImageView.setAnchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
         stackView.setAnchor(width: self.frame.width - 60, height: 310)
               stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
               stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
    }
    
     @objc func handleSubmit(){
           submitAction?()
       }
       @objc func handleCancel(){
           cancelAction?()
       }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
