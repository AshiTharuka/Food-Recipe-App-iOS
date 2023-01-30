//
//  YoutubeSearchResponse.swift
//  Food Reciepe App
//
//  Created by Ashi on 1/26/23.
//  Copyright © 2023 Ashi. All rights reserved.
//

import Foundation


struct YoutubeSearchResponse: Codable {
    let items: [VideoElement]
}

struct VideoElement: Codable{
    let id: IdVideoElement
}

struct IdVideoElement: Codable{
    let kind: String
    let videoId: String
}
