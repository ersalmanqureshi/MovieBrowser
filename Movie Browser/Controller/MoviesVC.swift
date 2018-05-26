//
//  ViewController.swift
//  MDSAT
//
//  Created by Salman Qureshi on 5/25/18.
//  Copyright © 2018 Salman Qureshi. All rights reserved.
//

import UIKit

class MoviesVC: UIViewController {

    //MARK: Outlet
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var browserCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        API.getMovies(page: 1) { movies in
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

