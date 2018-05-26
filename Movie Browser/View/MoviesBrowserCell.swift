//
//  MoviesBrowserCell.swift
//  Movie Browser
//
//  Created by Salman Qureshi on 5/26/18.
//  Copyright © 2018 Salman Qureshi. All rights reserved.
//

import UIKit

class MoviesBrowserCell: UICollectionViewCell {
    
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    
    static let reuseIdentifier = "MoviesBrowserCell"
}
