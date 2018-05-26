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
    case highestRated(page: Int)
}

extension MovieAPI: TargetType {
    var headers: [String : String]? {
        return ["Content-type" : "application/json"]
    }
    
    var sampleData: Data {
        return Data()
    }

    
    var baseURL: URL {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/") else {
            fatalError("url not configured")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .mostPopular:
            return "popular"
        case .highestRated:
            return "now_playing"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .mostPopular, .highestRated:
            return URLEncoding.queryString
        }
    }
    
    var task: Task {
        switch self {
        case .mostPopular (let page), .highestRated (let page):
            return .requestParameters(parameters: ["page": page, "api_key": API.apiKey], encoding: URLEncoding.queryString)
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .mostPopular(let page), .highestRated(let page):
            return ["page": page, "api_key=": API.apiKey]
        }
    }
    
    
}

