//
//  ViewController.swift
//  Movie Browser
//
//  Created by Salman Qureshi on 5/25/18.
//  Copyright © 2018 Salman Qureshi. All rights reserved.
//

import UIKit

class MoviesVC: UIViewController {

    //MARK: Outlet
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var browserCollectionView: UICollectionView!
    
    var movies: [Movie]? = []
    
    let segueIdentifier = "MovieBrowserToDetailSegue"
    
      let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupCollectionView()
        fetchMovies()
    }
    
    func fetchMovies() {
        API.getMovies(page: 1) { results in
            self.movies = results
            self.browserCollectionView.reloadData()
        }
    }
    
    func fetchMostPopularMovies() {
        API.getPopularMovies(page: 1) { results in
            self.movies = results
            self.browserCollectionView.reloadData()
        }
    }
    
    func fetchTopRated() {
        API.getTopRatedMovies(page: 1) { results in
            self.movies = results
            self.browserCollectionView.reloadData()
        }
    }
    
    func setupSearchBar() {
        searchBar.placeholder = "Search Movies..."
        searchBar.delegate = self
    }
    
    func setupCollectionView() {
        browserCollectionView.dataSource = self
        browserCollectionView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier {
            let destinationVC = segue.destination as! MoviesDetailVC
            destinationVC.movie = sender as! Movie
        }
    }
    
    func moviesOnSearch(_ search: String){
        
        activityIndicator.startAnimating()
        
        API.searchMovies(text: search) { response in
            
            DispatchQueue.main.async{
                self.movies = response
                self.activityIndicator.stopAnimating()
                self.browserCollectionView.reloadData()
            }
        }
    }
    
    func setupActivityIndicator(){
        // set up activity indicator
        activityIndicator.center = CGPoint(x: view.bounds.size.width/2, y: view.bounds.size.height/2)
        activityIndicator.color = UIColor.gray
        browserCollectionView.addSubview(activityIndicator)
    }
    
    @IBAction func sortBy(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Sort By", message: "", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Most Popular", style: .default , handler:{ (UIAlertAction)in
            self.fetchMostPopularMovies()
        }))
        
        alert.addAction(UIAlertAction(title: "Top Rated", style: .default , handler:{ (UIAlertAction)in
            self.fetchTopRated()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{ (UIAlertAction)in
            print("User click Dismiss button")
        }))
        
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
        
    }
    
}

extension MoviesVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       moviesOnSearch(searchText)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
}

extension MoviesVC: UICollectionViewDataSource {
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesBrowserCell.reuseIdentifier, for: indexPath) as? MoviesBrowserCell else {
            return UICollectionViewCell()
        }
        
        cell.movie = movies?[indexPath.row]
        return cell
    }
}

extension MoviesVC:  UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = movies![indexPath.row]
        performSegue(withIdentifier: segueIdentifier, sender: movie)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let dimen = view.frame.width / 2
        let knowHeight: CGFloat = view.frame.width / 2 * 1.2
        return CGSize(width: dimen , height: knowHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

