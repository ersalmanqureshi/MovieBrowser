//
//  MoviesDetailVC.swift
//  Movie Browser
//
//  Created by Salman Qureshi on 5/27/18.
//  Copyright © 2018 Salman Qureshi. All rights reserved.
//

import UIKit
import Kingfisher

class MoviesDetailVC: UIViewController {

    @IBOutlet weak var moviePosterThumbnail: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var movieReleasedate: UILabel!
    
    var movie: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ImageCache.default.retrieveImage(forKey: movie.title, options: nil) {
            image, cacheType in
            if let image = image {
                print("Get image \(image), cacheType: \(cacheType).")
                self.moviePosterThumbnail.image = image
                //In this code snippet, the `cacheType` is .disk
            } else {
                print("Not exist in cache.")
            }
        }//        moviePosterThumbnail.kf.setImage(with: url, options: [.onlyFromCache])
        movieTitle.text = movie.title
        movieOverview.text = movie.overview
        movieRating.text = "Rating: " + String(ceil(movie.rating / 2))
        movieReleasedate.text = "Released Date: \(movie.releaseDate)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
