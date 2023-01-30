//
//  BreakfastHeaderView.swift
//  Food Reciepe App
//
//  Created by Ashi on 1/4/23.
//  Copyright © 2023 Ashi. All rights reserved.
//

import UIKit
import FireStore
import FirebaseStorage

class BreakfastHeaderView: UIView {
    
    
    
    private let viewButton: UIButton = {
        let button = UIButton()
        button.setTitle("View", for: .normal)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let FavButton: UIButton = {
        let button = UIButton()
        button.setTitle("Favorite", for: .normal)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let BreakfastImgView: UIImageView = {
        
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        //imgView.image = UIImage(named: "YelloRice")
        return imgView
        
    }()
    
    private func addGradient(){
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(BreakfastImgView)
        addGradient()
        addSubview(viewButton)
        applyViewConstraints()
        addSubview(FavButton)
     applyFavConstraints()
        
        let storage = Storage.storage().reference().child("Images/Foodset.jpg")
            
            storage.getData(maxSize: 1 * 1024 * 1024) { data, error in
                if error != nil {
                    print(error?.localizedDescription)
                }
                else {
                    let image = UIImage(data: data!)
                    self.BreakfastImgView.image = image
                    
                    storage.downloadURL {url, error in
                        if error != nil {
                            print(error?.localizedDescription)
                        }else {
                            print(url ?? "url")
                        }
                    
                }
                
            }
            
            
        }
        
        
    }
    public func configure(with model: TitleViewModel){
         guard let url = URL(string: model.posterURL) else { return }
        BreakfastImgView.sd_setImage(with: url, completed: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func applyViewConstraints(){
        let ViewBtnConstraints = [
            viewButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 80),
            viewButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            viewButton.widthAnchor.constraint(equalToConstant: 100)]

        NSLayoutConstraint.activate(ViewBtnConstraints)
        
        
    }
    
    private func applyFavConstraints(){
        let FavBtnConstraints = [
        FavButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -90),
        FavButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
        FavButton.widthAnchor.constraint(equalToConstant: 100)]
        
        NSLayoutConstraint.activate(FavBtnConstraints)
    }
    
   
    
    
   
    
    
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        BreakfastImgView.frame = bounds
        
        
    }
    
    
    
}

