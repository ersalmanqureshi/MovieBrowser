//
//  MovieResults.swift
//  Movie Browser
//
//  Created by Salman Qureshi on 5/25/18.
//  Copyright © 2018 Salman Qureshi. All rights reserved.
//

import Foundation

struct MovieResults: Decodable {
    var page: Int
    var numberOfResults: Int
    var numberOfPages: Int
    var movies: [Movie]
    
    private enum CodingKeys: String, CodingKey {
        case page, numberOfResults = "total_results", numberOfPages = "total_pages", movies = "results"
    }
}
