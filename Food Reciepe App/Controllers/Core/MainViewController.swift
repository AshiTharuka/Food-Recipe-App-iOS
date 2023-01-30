//
//  ViewController.swift
//  Food Reciepe App
//
//  Created by Ashi on 1/2/23.
//  Copyright © 2023 Ashi. All rights reserved.
//

import UIKit
import FirebaseStorage

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "What to eat?"
        
        let home = UINavigationController(rootViewController: HomeViewController())
        let search = UINavigationController(rootViewController: SearchViewController())
        let newrep = UINavigationController(rootViewController: NewReciepeViewController())
        let fav = UINavigationController(rootViewController: FavoriteViewController())
        
        home.tabBarItem.image = UIImage(systemName: "house")
        search.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        newrep.tabBarItem.image = UIImage(systemName: "book")
        fav.tabBarItem.image = UIImage(systemName: "heart")
        home.title = "Home"
        search.title = "Search"
        newrep.title = "New Recipes"
        fav.title = "Favorite"
        
        tabBar.tintColor = .label
        
        
        setViewControllers([home,search,newrep,fav],  animated: true)
        
    }


}

