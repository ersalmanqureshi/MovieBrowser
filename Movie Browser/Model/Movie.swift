//
//  Movie.swift
//  Movie Browser
//
//  Created by Salman Qureshi on 5/25/18.
//  Copyright © 2018 Salman Qureshi. All rights reserved.
//

import Foundation

struct Movie: Decodable {
    let id:Int!
    let posterPath: String
    var videoPath: String?
    let backdrop: String
    let title: String
    var releaseDate: String
    var rating: Double
    let overview: String
    
    private enum CodingKeys: String, CodingKey {
        case id, posterPath = "poster_path", videoPath, backdrop = "backdrop_path", title, releaseDate = "release_date", rating = "vote_average", overview
    }
}
