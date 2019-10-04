//
//  MovieCollection.swift
//  MovieFinder
//
//  Created by Christopher Alegre on 10/4/19.
//  Copyright © 2019 Christopher Alegre. All rights reserved.
//

import Foundation

struct TopLevelMovieCollection: Decodable {
    
    let results: [ResultDictionary]
}

struct ResultDictionary: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case title
        case vote = "vote_average"
        case overview
        case poster = "poster_path"
    }
    
    let title: String
    let vote: Double
    let overview: String
    let poster: String
}
