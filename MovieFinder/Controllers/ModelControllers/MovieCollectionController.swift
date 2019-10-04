//
//  MovieCollectionController.swift
//  MovieFinder
//
//  Created by Christopher Alegre on 10/4/19.
//  Copyright © 2019 Christopher Alegre. All rights reserved.
//

import UIKit

class MovieCollectionController {
    
    static let shared = MovieCollectionController()
    
    static func getMovie(searchTerm: String, completion: @escaping ([ResultDictionary]) -> Void) {
        guard var url = URL(string: MovieURLConstants.baseURL) else { completion([]); return }
        url.appendPathComponent(MovieURLConstants.searchComponent)
        url.appendPathComponent(MovieURLConstants.movieComponent)
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {completion([]); return}
        let apiKeyQueary  = URLQueryItem(name: MovieURLConstants.apiKey, value: MovieURLConstants.apiKeyCode)
        let searchQuery = URLQueryItem(name: MovieURLConstants.searchFilterQueary, value: searchTerm)
        
        urlComponents.queryItems = [apiKeyQueary, searchQuery]
        
        guard let finalUrl = urlComponents.url else {
            print("Components have not been set correctly")
            completion([])
            return }
        
        URLSession.shared.dataTask(with: finalUrl) { (data, _, error) in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                completion([])
                return }
            guard let data = data else {
                print("Data could not be set")
                completion([])
                return }
            
            let jsonDecoder = JSONDecoder()
            do {
                let movieDecoder = try jsonDecoder.decode(TopLevelMovieCollection.self, from: data)
                completion(movieDecoder.results)
            } catch {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)") }
        } .resume()
    }
    
    static func fetchImage(movie: ResultDictionary, completion: @escaping (UIImage?) -> Void) {
        guard var posterUrl = URL(string: MovieURLConstants.posterURLBase) else { completion(nil); return }
        posterUrl.appendPathComponent(movie.poster)
        guard let urlPosterComponents = URLComponents(url: posterUrl, resolvingAgainstBaseURL: true) else { completion(nil); return}
        guard let finalPosterUrl = urlPosterComponents.url else {
            print("Could not set Poster image components")
            completion(nil)
            return }
        
        URLSession.shared.dataTask(with: finalPosterUrl) { (data, _, error) in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                completion(nil)
                return }
            guard let data = data else {
                print("Could not decode Poster image data")
                completion(nil)
                return }
            
            guard let image = UIImage(data: data) else { completion(nil); return }
            completion(image)
        } .resume()
    }
    
}

