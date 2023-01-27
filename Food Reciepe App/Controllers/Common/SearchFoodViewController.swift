//
//  SearchFoodViewController.swift
//  Food Reciepe App
//
//  Created by Ashi on 1/26/23.
//  Copyright © 2023 Ashi. All rights reserved.
//

import UIKit

protocol SearchFoodViewControllerDelegate: AnyObject {
    func SearchFoodViewControllerDidTapItem(_ viewModel: RecipePreviewViewModel)
    
}

class SearchFoodViewController: UIViewController {
    
    public var foods: [Food] = [Food]()
    
    public weak var delegate: SearchFoodViewControllerDelegate?
    
    public let searchFoodCollectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10, height: 200)
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
    return collectionView
    
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        view.addSubview(searchFoodCollectionView)
        
        searchFoodCollectionView.delegate = self
        searchFoodCollectionView.dataSource = self
    }
    
    override func viewDidLayoutSubviews(){
        super.viewDidLayoutSubviews()
        searchFoodCollectionView.frame = view.bounds
    }
    


}

extension SearchFoodViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foods.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else {
            return UICollectionViewCell()
    }
        let title = foods[indexPath.row]
        cell.configure(with: title.url ?? "")
        return cell
}
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let food = foods[indexPath.row]
        let titleName = food.FoodName ?? ""
        
        APICaller.shared.getFoodDesc(with: titleName ) { [weak self] result in
                 switch result {
                 case .success(let videoElement):
                    self?.delegate?.SearchFoodViewControllerDidTapItem(RecipePreviewViewModel(title: titleName, youtubeView: videoElement, recipeDesc: food.Desc ?? ""))
                    
                 case .failure(let error):
                     print(error.localizedDescription)
                 }
             }
        
    }
    
    
}
