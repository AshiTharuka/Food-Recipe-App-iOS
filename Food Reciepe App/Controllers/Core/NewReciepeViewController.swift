//
//  NewReciepeViewController.swift
//  Food Reciepe App
//
//  Created by Ashi on 1/2/23.
//  Copyright © 2023 Ashi. All rights reserved.
//

import UIKit

class NewReciepeViewController: UIViewController {
    
    private var foods: [Food] = [Food]()
    
    private let newRecipeTable: UITableView = {
       
        let table = UITableView()
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "New Recipe"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        view.addSubview(newRecipeTable)
        newRecipeTable.delegate = self
        newRecipeTable.dataSource = self
        fetchNewRecipe()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        newRecipeTable.frame = view.bounds
    }
    
    private func fetchNewRecipe(){
        APICaller.shared.getTrendingFoods{ [weak self] result in
            switch result {
            case .success(let foods):
                self?.foods = foods
                DispatchQueue.main.async {
                    self?.newRecipeTable.reloadData()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
    }
    

    
}

extension NewReciepeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else {
            return UITableViewCell()
        }
        
        let food = foods[indexPath.row]
        cell.configure(with: TitleViewModel(foodName: food.FoodName ?? food.Category ?? "" , posterURL: food.url ?? ""))
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
                    vc.configure(with: RecipePreviewViewModel(title: food, youtubeView: videoElement, recipeDesc: desc.Desc ?? "", calories: desc.Calories))
                                   self?.navigationController?.pushViewController(vc, animated: true)
                                   
                }
               
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
