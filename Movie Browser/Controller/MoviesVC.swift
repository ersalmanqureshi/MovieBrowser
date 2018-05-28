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
    
      let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
    
    var page = 1
    var reachedEndOfItems = false
    
    var selection = "now_playing"
    
    var query = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTapGesture()
        setupSearchBar()
        setupCollectionView()
        fetchMovies()
    }
    
    func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func fetchMovies() {
        
        guard !self.reachedEndOfItems else {
            return
        }
        
        activityIndicator.startAnimating()
       
        API.getMovies(page: page) { results in
            
            DispatchQueue.main.async {
                self.movies?.append(contentsOf: results)
                self.activityIndicator.stopAnimating()
                self.selection = "now_playing"
                // check if this was the last of the data
                if self.movies!.count < 20 {
                    self.reachedEndOfItems = true
                    print("reached end of data. Batch count: \(self.movies!.count)")
                }
                
                // add the page for the next data query
                self.page += 1
                
                self.browserCollectionView.reloadData()
            }
        }
    }
    
    func fetchMostPopularMovies() {
        
        guard !self.reachedEndOfItems else {
            return
        }
        
        activityIndicator.startAnimating()
        
        API.getPopularMovies(page: page) { results in
            DispatchQueue.main.async {
                self.movies?.append(contentsOf: results)
                self.activityIndicator.stopAnimating()
                self.selection = "popular"
                // check if this was the last of the data
                if self.movies!.count < 20 {
                    self.reachedEndOfItems = true
                    print("reached end of data. Batch count: \(self.movies!.count)")
                }
                
                // add the page for the next data query
                self.page += 1
                
                self.browserCollectionView.reloadData()
            }
        }
    }
    
    func fetchTopRated() {
        
        guard !self.reachedEndOfItems else {
            return
        }
        
        activityIndicator.startAnimating()
        
        API.getTopRatedMovies(page: page) { results in
            DispatchQueue.main.async {
                self.movies?.append(contentsOf: results)
                self.activityIndicator.stopAnimating()
                self.selection = "topRated"
                // check if this was the last of the data
                if self.movies!.count < 20 {
                    self.reachedEndOfItems = true
                    print("reached end of data. Batch count: \(self.movies!.count)")
                }
                
                // add the page for the next data query
                self.page += 1
                
                self.browserCollectionView.reloadData()
            }
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
            self.movies?.removeAll()
            self.fetchMostPopularMovies()
        }))
        
        alert.addAction(UIAlertAction(title: "Top Rated", style: .default , handler:{ (UIAlertAction)in
            self.movies?.removeAll()
            self.fetchTopRated()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    
            
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension MoviesVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       query = searchText
        
        if searchText == "" {
            moviesOnSearch("")
        } else {
            moviesOnSearch(query)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        moviesOnSearch(searchBar.text!)
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
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == movies!.count - 1 {
            switch selection {
            case "now_playing":
                fetchMovies()
            case "popular":
                fetchMostPopularMovies()
            case "topRated":
                fetchTopRated()
            default:
                fetchMovies()
            }
        }
    }
}

