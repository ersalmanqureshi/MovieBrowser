//
//  API.swift
//  Movie Browser
//
//  Created by Salman Qureshi on 5/25/18.
//  Copyright © 2018 Salman Qureshi. All rights reserved.
//

import Foundation
import Moya

class API {
    static let apiKey = "8b73bac921b846f18c66df6583d5e085"
    static let imageBaseStr: String = "https://image.tmdb.org/t/p/"
    static let provider = MoyaProvider<MovieAPI>()
    
    static func getMovies(page: Int, completion: @escaping (([Movie]) -> ())) {
        provider.request(.nowPlaying(page: page)) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(MovieResults.self, from: response.data)
                    completion(results.movies)
                } catch let err{
                    print(err)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    static func getPopularMovies(page: Int, completion: @escaping (([Movie]) -> ())) {
        provider.request(.mostPopular(page: page)) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(MovieResults.self, from: response.data)
                    completion(results.movies)
                } catch let err{
                    print(err)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    static func searchMovies(text: String, completion: @escaping (([Movie]) -> ())) {
        provider.request(.search(text: text)) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(MovieResults.self, from: response.data)
                    completion(results.movies)
                } catch let err{
                    print(err)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
}
