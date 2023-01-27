//
//  SearchViewController.swift
//  Food Reciepe App
//
//  Created by Ashi on 1/2/23.
//  Copyright © 2023 Ashi. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    public var foods: [Food] = [Food]()
    
    private let searchRecipeTable: UITableView = {
       
        let table = UITableView()
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        return table
    }()
    
    private let searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: SearchFoodViewController())
        controller.searchBar.placeholder = "Search for a Food Recipe"
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         title = "Search"
               navigationController?.navigationBar.prefersLargeTitles = true
               navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        view.backgroundColor = .systemBackground
        view.addSubview(searchRecipeTable)
        navigationItem.searchController = searchController
        
        searchRecipeTable.delegate = self
        searchRecipeTable.dataSource = self
        fetchSearchFood()
        searchController.searchResultsUpdater = self
        
    }
    
    private func fetchSearchFood(){
        APICaller.shared.getSearchFoods{ [weak self] result in
            switch result {
            case .success(let foods):
                self?.foods = foods
                DispatchQueue.main.async {
                    self?.searchRecipeTable.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchRecipeTable.frame = view.bounds
    }

    

}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else {
            return UITableViewCell()
        }
        let food = foods[indexPath.row]
        let model = TitleViewModel(foodName: food.FoodName ?? "", posterURL: food.url ?? "")
        cell.configure(with: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let desc = foods[indexPath.row]
        
        let food = foods[indexPath.row].FoodName
       
        APICaller.shared.getFoodDesc(with: food) { [weak self] result in
            switch result {
            case .success(let videoElement):
                DispatchQueue.main.async {
                     let vc = RecipePreviewViewController()
                                   vc.configure(with: RecipePreviewViewModel(title: food, youtubeView: videoElement, recipeDesc: desc.Desc ?? ""))
                                   self?.navigationController?.pushViewController(vc, animated: true)
                                   
                }
               
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
extension SearchViewController: UISearchResultsUpdating, SearchFoodViewControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        guard let query = searchBar.text,
            !query.trimmingCharacters(in: .whitespaces).isEmpty,
        query.trimmingCharacters(in: .whitespaces).count >= 3,
            let resultsController = searchController.searchResultsController as? SearchFoodViewController else { return }
        
        resultsController.delegate = self
    
    
   APICaller.shared.getSearch(with: query) { result in
    DispatchQueue.main.async {
    switch result {
        case .success(let foods):
            resultsController.foods = foods
            resultsController.searchFoodCollectionView.reloadData()
        case .failure(let error):
            print(error.localizedDescription)
        
    
    }
    }
    }
}
    
    func SearchFoodViewControllerDidTapItem(_ viewModel: RecipePreviewViewModel) {
        DispatchQueue.main.async { [weak self] in
             let vc = RecipePreviewViewController()
                   vc.configure(with: viewModel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        
        
       
    }
}

