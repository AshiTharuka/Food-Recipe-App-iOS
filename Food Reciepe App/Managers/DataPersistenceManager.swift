//
//  DataPersistenceManager.swift
//  Food Reciepe App
//
//  Created by Ashi on 1/26/23.
//  Copyright © 2023 Ashi. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DataPersistenceManager {
    
    enum DatabaseError: Error {
        case failedToSaveData
        case failedToFetchData
        case failedToDelete
    }
    
    static let shared = DataPersistenceManager()
    
    func favoriteTitleWith(model: Food, completion: @escaping (Result<Void, Error>) -> Void){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let item = FoodTitle(context: context)
        
        item.name = model.FoodName
        item.category = model.Category
        item.desc = model.Desc
        item.url = model.url
        
        do{
            try context.save()
            completion(.success(()))
        }catch {
            completion(.failure(DatabaseError.failedToSaveData))
        }
    }
    
    func fetchingFoodsFromDB(completion: @escaping (Result<[FoodTitle], Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request: NSFetchRequest<FoodTitle>
        
        request = FoodTitle.fetchRequest()
        do{
            let foods = try context.fetch(request)
            completion(.success(foods))
            
        }catch {
            completion(.failure(DatabaseError.failedToFetchData))
        }
    }
    
    func deleteFoodWith(model: FoodTitle, completion: @escaping (Result<Void, Error>) -> Void) {
        
         guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        
        context.delete(model)
        do{
            try context.save()
            completion(.success(()))
            
        }catch {
            completion(.failure(DatabaseError.failedToDelete))
        }
                   }
}
