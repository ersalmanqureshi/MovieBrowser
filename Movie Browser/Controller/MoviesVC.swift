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
        
        setupCollectionView()
        
        
        API.getMovies(page: 1) { movies in
            
        }
    }
    
    func setupCollectionView() {
        browserCollectionView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension MoviesVC: UICollectionViewDataSource {
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesBrowserCell.reuseIdentifier, for: indexPath) as? MoviesBrowserCell else {
            return UICollectionViewCell()
        }
        
        return cell
    }
}

