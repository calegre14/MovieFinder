//
//  MovieTableViewCell.swift
//  MovieFinder
//
//  Created by Christopher Alegre on 10/4/19.
//  Copyright © 2019 Christopher Alegre. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    var movie: ResultDictionary? {
        didSet {
            updateViews()
        }
    }

    @IBOutlet weak var moviePosterImage: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var movieOverviewTextView: UITextView!
    
    func updateViews() {
        movieTitleLabel.text = movie?.title
        movieRatingLabel.text = "\(movie?.vote ?? 0)"
        movieOverviewTextView.text = movie?.overview
        guard let movie = movie else {return}
        MovieCollectionController.fetchImage(movie: movie) { (poster) in
            DispatchQueue.main.async {
                self.moviePosterImage.image = poster
            }
        }
    }
}
