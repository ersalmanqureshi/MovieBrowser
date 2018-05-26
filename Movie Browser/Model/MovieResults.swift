//
//  MovieResults.swift
//  Movie Browser
//
//  Created by Salman Qureshi on 5/25/18.
//  Copyright © 2018 Salman Qureshi. All rights reserved.
//

import Foundation

struct MovieResults: Decodable {
    let page: Int
    let numResults: Int
    let numPages: Int
    let movies: [Movie]
    
    private enum CodingKeys: String, CodingKey {
        case page, numResults = "total_results", numPages = "total_pages", movies  = "results"
    }
}

struct VideoResults: Decodable {
    let details: [VideoKey]
    private enum CodingKeys: String, CodingKey {
        case details = "results"
    }
}

struct VideoKey: Decodable {
    let key: String
}
