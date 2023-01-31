//
//  TitleTableViewCell.swift
//  Food Reciepe App
//
//  Created by Ashi on 1/26/23.
//  Copyright © 2023 Ashi. All rights reserved.
//

import UIKit

class TitleTableViewCell: UITableViewCell {

    static let identifier = "TitleTableViewCell"
    
    private let viewButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "eye", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25))
        button.setImage(image,  for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .black
       return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let titlePosterImgView: UIImageView = {
       let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
         imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.clipsToBounds = true
        imgView.layer.masksToBounds = true
        return imgView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titlePosterImgView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(viewButton)
        applyConstraints()
    }
    
    private func applyConstraints(){
        let titlePosterImgViewConstraints = [
            titlePosterImgView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titlePosterImgView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titlePosterImgView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            titlePosterImgView.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        let titleLabelConstraints = [
            titleLabel.leadingAnchor.constraint(equalTo: titlePosterImgView.trailingAnchor, constant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ]
        
        let viewButtonConstraints = [
            viewButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            viewButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        
        ]
        
        NSLayoutConstraint.activate(titlePosterImgViewConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(viewButtonConstraints)
    }
    
    public func configure(with model: TitleViewModel){
        guard let url = URL(string: model.posterURL) else { return }
        
        
        
        titlePosterImgView.sd_setImage(with: url, completed: nil)
        titleLabel.text = model.foodName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
