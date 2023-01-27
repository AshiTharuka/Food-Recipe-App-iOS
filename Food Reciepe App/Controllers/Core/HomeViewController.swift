//
//  HomeViewController.swift
//  Food Reciepe App
//
//  Created by Ashi on 1/2/23.
//  Copyright © 2023 Ashi. All rights reserved.
//

import UIKit
import Firebase

enum Section: Int {
    case Breakfast_Food = 0
    case Lunch_Food = 1
    case Dinner_food = 2
    case Diets_Food = 3
}

class HomeViewController: UIViewController {
    
    private var randomFoods: Food?
    private var headerView: BreakfastHeaderView?
    
    let sectionFoods: [String] = ["Breakfast", "Lunch", "Dinner", "Desserts"]
    
    private let homeView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionTableViewCell.self, forCellReuseIdentifier: CollectionTableViewCell.identifier)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        view.addSubview(homeView)
        
        homeView.delegate = self
        homeView.dataSource = self
        
        configureNavbar()
        
        headerView = BreakfastHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 400))
        homeView.tableHeaderView = headerView
        configureBreakfastHeaderView()
    }
    
    private func configureBreakfastHeaderView(){
        APICaller.shared.getBreakfastFoods { [weak self] result in
            switch result {
            case .success(let foods):
                let selectedTitle = foods.randomElement()
                self?.randomFoods = selectedTitle
                self?.headerView?.configure(with: TitleViewModel(foodName: selectedTitle?.FoodName ?? "", posterURL: selectedTitle?.url ?? ""))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    
    private func configureNavbar(){
        var image = UIImage(named: "logo")
        image = image?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "slider.horizontal.3"), style: .done, target: self, action: nil)
        ]
        navigationController?.navigationBar.tintColor = .black
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeView.frame = view.bounds
    }
    
    
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionFoods.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionTableViewCell.identifier, for: indexPath) as? CollectionTableViewCell else{
            return UITableViewCell()
        }
        
        cell.delegate = self
        
        switch indexPath.section {
        case Section.Breakfast_Food.rawValue:
            
            APICaller.shared.getBreakfastFoods{ result in
                switch result {
                case .success(let foods):
                    cell.configure(with: foods)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        case Section.Lunch_Food.rawValue:
            
            APICaller.shared.getLunchFoods{ result in
                switch result {
                case .success(let foods):
                    cell.configure(with: foods)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Section.Dinner_food.rawValue:
            
            APICaller.shared.getDinnerFoods{ result in
                switch result {
                case .success(let foods):
                    cell.configure(with: foods)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Section.Diets_Food.rawValue:
            
            APICaller.shared.getDessertFoods{ result in
                switch result {
                case .success(let foods):
                    cell.configure(with: foods)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        default:
            return UITableViewCell()
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .black
        header.textLabel?.text = header.textLabel?.text?.capitalized
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionFoods[section]
    }
    
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
    
    
}

extension HomeViewController: CollectionTableViewCellDelegate {
    func CollectionTableViewCellDidTapCell(_ cell: CollectionTableViewCell, viewModel: RecipePreviewViewModel) {
        DispatchQueue.main.async { [weak self] in
            let vc = RecipePreviewViewController()
            
            vc.configure(with: viewModel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}
