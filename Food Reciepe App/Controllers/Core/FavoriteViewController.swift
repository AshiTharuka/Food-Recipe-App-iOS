//
//  FavoriteViewController.swift
//  Food Reciepe App
//
//  Created by Ashi on 1/2/23.
//  Copyright © 2023 Ashi. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    private var foods: [FoodTitle] = [FoodTitle]()
    
    
     private let favoriteTable: UITableView = {
          
           let table = UITableView()
           table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
           return table
       }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        view.addSubview(favoriteTable)
        favoriteTable.delegate = self
        favoriteTable.dataSource = self
        fetchLocalStorageForDownload()
        NotificationCenter.default.addObserver(forName: NSNotification.Name("Add To Favorite"), object: nil, queue: nil) { _ in
            self.fetchLocalStorageForDownload()
        }
    }
    
    private func fetchLocalStorageForDownload(){
        DataPersistenceManager.shared.fetchingFoodsFromDB { [weak self] result in
            switch result {
            case .success(let foods):
                self?.foods = foods
                DispatchQueue.main.async {
                    self?.favoriteTable.reloadData()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        favoriteTable.frame = view.bounds
    }
    

  }



extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return foods.count
       }
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else {
               return UITableViewCell()
           }
           
           let food = foods[indexPath.row]
        cell.configure(with: TitleViewModel(foodName: (food.name ?? food.category) ?? "" , posterURL: food.url ?? ""))
           return cell
       }
       
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 140
       }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            
            DataPersistenceManager.shared.deleteFoodWith(model: foods[indexPath.row]) { [weak self] result in
                switch result {
                case .success():
                    print("Deleted from the DB")
                case .failure(let error):
                    print(error.localizedDescription)
                }
                 self?.foods.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
               
            }
            
     default:
        break;
        }
    }
    
      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          tableView.deselectRow(at: indexPath, animated: true)
          
          let item = foods[indexPath.row]
          
          let food = foods[indexPath.row].name
         
        APICaller.shared.getFoodDesc(with: food ?? "") { [weak self] result in
              switch result {
              case .success(let videoElement):
                  DispatchQueue.main.async {
                       let vc = RecipePreviewViewController()
                    vc.configure(with: RecipePreviewViewModel(title: food ?? "", youtubeView: videoElement, recipeDesc: item.desc ?? "" , calories: item.calories ?? ""))
                                     self?.navigationController?.pushViewController(vc, animated: true)
                                     
                  }
                 
              case .failure(let error):
                  print(error.localizedDescription)
              }
          }
      }

}

