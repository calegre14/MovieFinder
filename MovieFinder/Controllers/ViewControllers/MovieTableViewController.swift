//
//  MovieTableViewController.swift
//  MovieFinder
//
//  Created by Christopher Alegre on 10/4/19.
//  Copyright © 2019 Christopher Alegre. All rights reserved.
//

import UIKit

class MovieTableViewController: UITableViewController {
    
    var movies: [ResultDictionary] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    @IBOutlet weak var movieSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.estimatedRowHeight = 200
        self.tableView.rowHeight = 200
        movieSearchBar.delegate = self
        
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell else {return UITableViewCell()}
        cell.movie = movies[indexPath.row]
        
        return cell
    }
}

extension MovieTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        MovieCollectionController.getMovie(searchTerm: searchText) { (movies) in
            self.movies = movies }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}
