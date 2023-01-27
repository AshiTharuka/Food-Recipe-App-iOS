//
//  CollectionTableViewCell.swift
//  Food Reciepe App
//
//  Created by Ashi on 1/3/23.
//  Copyright © 2023 Ashi. All rights reserved.
//

import UIKit
protocol CollectionTableViewCellDelegate: AnyObject {
    func CollectionTableViewCellDidTapCell(_ cell: CollectionTableViewCell, viewModel: RecipePreviewViewModel)
}

class CollectionTableViewCell: UITableViewCell {

   static let identifier = "CollectionTableViewCell"
    
    weak var delegate: CollectionTableViewCellDelegate?
    private var foods: [Food] = [Food]()
    
    private let collectionViews: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 140, height: 200)
        layout.scrollDirection = .horizontal
        let collectionView  = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        collectionView.backgroundColor = .systemGray5
        return collectionView
        
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemGray5
        contentView.addSubview(collectionViews)
        
        collectionViews.delegate = self
        collectionViews.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionViews.frame = contentView.bounds
    }
    
    public func configure(with foods: [Food]){
        self.foods = foods
        DispatchQueue.main.async { [weak self] in
            self?.collectionViews.reloadData()
        }
    }
    
    private func favoriteTitle(indexPath: IndexPath){
        DataPersistenceManager.shared.favoriteTitleWith(model: foods[indexPath.row]) { result in
            switch result {
            case .success():
                NotificationCenter.default.post(name: NSNotification.Name("Add to Favorite"), object: nil)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension CollectionTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else { return UICollectionViewCell() }
        
        let model = foods[indexPath.row].url
        cell.configure(with: model)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foods.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let food = foods[indexPath.row].FoodName
       
        
        APICaller.shared.getFoodDesc(with: food) { [weak self] result in
            switch result {
            case .success(let videoElement):
                let title = self?.foods[indexPath.row]
                guard let recipeOverView = title?.Desc else { return }
                guard let strongSelf = self else { return }
                let viewModel = RecipePreviewViewModel(title: food , youtubeView: videoElement, recipeDesc: recipeOverView)
                self?.delegate?.CollectionTableViewCellDidTapCell(strongSelf, viewModel: viewModel)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }


    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let config = UIContextMenuConfiguration(
        identifier: nil, previewProvider: nil) { [weak self] _ in
            let favoriteAction = UIAction(title: "Favorite", image: nil, identifier: nil, discoverabilityTitle: nil, state: .off) { _ in
                self?.favoriteTitle(indexPath: indexPath)
            }
            return UIMenu(title: "", image: nil, identifier: nil, options: .displayInline, children: [favoriteAction])
        }
        return config
    }
    
    
    
    
}
