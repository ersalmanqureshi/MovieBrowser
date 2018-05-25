//
//  Movie.swift
//  Movie Browser
//
//  Created by Salman Qureshi on 5/25/18.
//  Copyright © 2018 Salman Qureshi. All rights reserved.
//

import Foundation

struct Movie: Decodable {
    var id: Int!
    var originalTitle: String
    var posterImageThumbnail: String?
    var overview: String
    var rating: Double
    var releaseYear: String
    
    private enum CodingKeys: String, CodingKey {
        case id, originalTitle, releaseYear = "release_date", rating = "vote_average", posterImageThumbnail = "poster_path", overview
    }
}
