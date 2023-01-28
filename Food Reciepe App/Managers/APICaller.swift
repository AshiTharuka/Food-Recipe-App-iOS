//
//  APICaller.swift
//  Food Reciepe App
//
//  Created by Ashi on 1/25/23.
//  Copyright © 2023 Ashi. All rights reserved.
//

import Foundation

struct Constants {
    static let API_KEY = "AIzaSyC8WPtuGgfis6ZcvKlWUg1VO8IIdQ63QvU"
    static let baseURL = "https://firestore.googleapis.com/v1/projects"
    static let youtubeBaseURL = "https://youtube.googleapis.com/youtube/v3/search?"
}

enum APIError: Error {
    case failedTogetData
}

class APICaller {
    static let shared = APICaller()
    
    func getBreakfastFoods(completion: @escaping (Result<[Food],Error>) -> Void){
    
    guard let url = URL(string: "\(Constants.baseURL)/food-reciepe-iosapp/databases/(default)/documents/Breakfast_Food") else { return }
    let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
        guard let data = data, error == nil else { return }
    
        do{
            let results = try JSONDecoder().decode(FoodResponses.self, from: data)
            completion(.success(results.foods))
            
            
            //print(results)
        }catch {
            completion(.failure(APIError.failedTogetData))
        }
    
    }
    
    task.resume()
}
    
    
    func getLunchFoods(completion: @escaping (Result<[Food],Error>) -> Void){
        
        guard let url = URL(string: "\(Constants.baseURL)/food-reciepe-iosapp/databases/(default)/documents/Lunch_Food") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
        
            do{
                let results = try JSONDecoder().decode(FoodResponses.self, from: data)
                completion(.success(results.foods))
                
                
                //print(results)
            }catch {
                
                completion(.failure(APIError.failedTogetData))
            }
        
        }
        
        task.resume()
    }

    
    func getDinnerFoods(completion: @escaping (Result<[Food],Error>) -> Void){
        
        guard let url = URL(string: "\(Constants.baseURL)/food-reciepe-iosapp/databases/(default)/documents/Dinner_Food") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
        
            do{
                let results = try JSONDecoder().decode(FoodResponses.self, from: data)
                completion(.success(results.foods))
                
                
                //print(results)
            }catch {
                
                completion(.failure(APIError.failedTogetData))
            }
        
        }
        
        task.resume()
    }
    
    func getDessertFoods(completion: @escaping (Result<[Food],Error>) -> Void){
        
        guard let url = URL(string: "\(Constants.baseURL)/food-reciepe-iosapp/databases/(default)/documents/Diets_Food") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
        
            do{
                let results = try JSONDecoder().decode(FoodResponses.self, from: data)
                completion(.success(results.foods))
                
                
                //print(results)
            }catch {
                
                completion(.failure(APIError.failedTogetData))
            }
        
        }
        
        task.resume()
    }
    
    func getSearchFoods(completion: @escaping (Result<[Food],Error>) -> Void){
        
        guard let url = URL(string: "\(Constants.baseURL)/food-reciepe-iosapp/databases/(default)/documents/Trending_Food") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
        
            do{
                let results = try JSONDecoder().decode(FoodResponses.self, from: data)
                completion(.success(results.foods))
                
                
                //print(results)
            }catch {
                
                completion(.failure(APIError.failedTogetData))
            }
        
        }
        
        task.resume()
    }
    
    
    func getSearch(with query: String, completion: @escaping (Result<[Food],Error>) -> Void){
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        
        guard let url = URL(string: "\(Constants.baseURL)/food-reciepe-iosapp/databases/(default)/documents?&query=\(query)") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
        
            do{
                let results = try JSONDecoder().decode(FoodResponses.self, from: data)
                completion(.success(results.foods))
                
                
                //print(results)
            }catch {
                
                completion(.failure(APIError.failedTogetData))
            }
        
        }
        
        task.resume()
    }
    
    
    func getFoodDesc(with query: String, completion: @escaping (Result<VideoElement ,Error>) -> Void) {
        
         guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        guard let url = URL(string: "\(Constants.youtubeBaseURL)q=\(query)&key=\(Constants.API_KEY)") else { return }
        
         let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
                   guard let data = data, error == nil else { return }
               
                   do {
                    let results = try JSONDecoder().decode(YoutubeSearchResponse.self, from: data)
                       
                    completion(.success(results.items[0]))
                       //print(results)
                   }catch {
                    
                       completion(.failure(error))
                    print(error.localizedDescription)
                    
            }
               
               }
               
               task.resume()
    }
    
    
     func getTrendingFoods(completion: @escaping (Result<[Food],Error>) -> Void){
           
           guard let url = URL(string: "\(Constants.baseURL)/food-reciepe-iosapp/databases/(default)/documents/Trending_Food") else { return }
           let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
               guard let data = data, error == nil else { return }
           
               do{
                   let results = try JSONDecoder().decode(FoodResponses.self, from: data)
                   completion(.success(results.foods))
                   
                   
                   //print(results)
               }catch {
                   
                   completion(.failure(APIError.failedTogetData))
               }
           
           }
           
           task.resume()
       }
    
}
