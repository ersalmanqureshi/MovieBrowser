//
//  MovieAPI.swift
//  Movie Browser
//
//  Created by Salman Qureshi on 5/25/18.
//  Copyright © 2018 Salman Qureshi. All rights reserved.
//

import Foundation
import Moya

enum MovieAPI {
    case mostPopular(page: Int)
    case nowPlaying(page: Int)
    case search(text: String)
}

extension MovieAPI: TargetType {
    var headers: [String : String]? {
        return ["Content-type" : "application/json"]
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var baseURL: URL {
        guard let url = URL(string: "https://api.themoviedb.org/3/") else {
            fatalError("url not configured")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .mostPopular:
            return "movie/popular"
        case .nowPlaying:
            return "movie/now_playing"
        case .search:
            return "search/movie"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .mostPopular, .nowPlaying, .search:
            return URLEncoding.queryString
        }
    }
    
    var task: Task {
        switch self {
        case .mostPopular (let page), .nowPlaying (let page):
            return .requestParameters(parameters: ["page": page, "api_key": API.apiKey], encoding: URLEncoding.queryString)
        
        case .search (let query):
            return .requestParameters(parameters: ["query": query, "api_key": API.apiKey], encoding: URLEncoding.queryString)
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .mostPopular(let page), .nowPlaying(let page):
            return ["page": page, "api_key=": API.apiKey]
        case .search(let query):
            return ["query": query, "api_key=": API.apiKey]
        }
    }
}

