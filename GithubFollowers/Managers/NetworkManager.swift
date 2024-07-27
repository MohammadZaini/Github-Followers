//
//  NetworkManager.swift
//  GithubFollowers
//
//  Created by Moe on 26/07/2024.
//

import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private let baseURL = "https://api.github.com/users/"
    let cache           = NSCache<NSString, UIImage>()
    
    func getFollowers(username: String, page: Int, completion: @escaping (Result<[Follower], GFError>) -> Void) {
        let endPoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endPoint) else {
            
            completion(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                
                let decorder = JSONDecoder()
                decorder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decorder.decode([Follower].self, from: data)
                completion(.success(followers))
                
            } catch {
                completion(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
}
