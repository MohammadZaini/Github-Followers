//
//  NetworkManager.swift
//  GithubFollowers
//
//  Created by Moe on 26/07/2024.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    let baseURL = "https://api.github.com/users/"
    
    func getFollowers(username: String, page: Int, completion: @escaping ([Follower]?, String?) -> Void) {
        let endPoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endPoint) else {
            
            completion(nil,"Something went wrong")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                completion(nil, "Something went wrong")
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(nil, "Something went wrong")
                return
            }
            
            guard let data = data else {
                completion(nil, "Something went wrong")
                return
            }
            
            do {
                
                let decorder = JSONDecoder()
                decorder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decorder.decode([Follower].self, from: data)
                completion(followers, nil)
                
            } catch {
                completion(nil, "Something went wrong")
            }
        }
        
        task.resume()
    }
}
