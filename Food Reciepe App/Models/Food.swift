//
//  Food.swift
//  Food Reciepe App
//
//  Created by Ashi on 1/25/23.
//  Copyright © 2023 Ashi. All rights reserved.
//

import UIKit

struct FoodResponses: Codable {
    let foods: [Food]
    
    private enum CodingKeys: String, CodingKey {
        case foods = "documents"
    }
}

struct StringValue: Codable {
    let value: String
    
    private enum CodingKeys: String, CodingKey {
        case value = "stringValue"
    }
}

struct Food: Codable {
    let FoodName: String
    let Category: String
    let Desc: String
    let url: String
    
    private enum FoodKeys: String, CodingKey {
        case fields
    }
    
    private enum FieldKeys: String, CodingKey {
        case FoodName
        case Category
        case url
        case Desc
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: FoodKeys.self)
        let fieldContainer = try container.nestedContainer(keyedBy: FieldKeys.self, forKey: .fields)
        
        FoodName = try fieldContainer.decode(StringValue.self, forKey: .FoodName).value
        Category = try fieldContainer.decode(StringValue.self, forKey: .Category).value
        Desc = try fieldContainer.decode(StringValue.self, forKey: .Desc).value
        url = try fieldContainer.decode(StringValue.self, forKey: .url).value
        
    }
}


