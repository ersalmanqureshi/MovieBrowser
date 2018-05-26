//
//  MoviesBrowserCell.swift
//  Movie Browser
//
//  Created by Salman Qureshi on 5/26/18.
//  Copyright © 2018 Salman Qureshi. All rights reserved.
//

import UIKit
import Kingfisher

class MoviesBrowserCell: UICollectionViewCell {
    
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    static let reuseIdentifier = "MoviesBrowserCell"
    
    var movie: Movie? {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {

        guard let movie = movie, let url = URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath)") else { return }
        
        let resource = ImageResource(downloadURL: url, cacheKey: movie.title)
        
        moviePoster.kf.setImage(with: resource, placeholder: UIImage(named: "avatar"), options: [.transition(.fade(0.3))])
        
        movieTitle.text = movie.title
    }
}
