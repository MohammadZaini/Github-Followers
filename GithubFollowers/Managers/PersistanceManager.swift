//
//  PersistanceManager.swift
//  GithubFollowers
//
//  Created by Moe on 31/07/2024.
//

import Foundation

enum PersistanceActionType {
    case add, remove
}

enum PersistanceManager {
    
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let favorites = "favorites"
    }
    
    
    static func updateWith(favorite: Follower, actionType: PersistanceActionType, completion: @escaping (GFError?) -> Void) {
        
        retrieveFavorites { result in
            switch result {
                
            case .success(let favorites):
                
                var retrievedFavorite = favorites
                
                switch actionType {
                    
                case .add:
                    guard !retrievedFavorite.contains(favorite) else {
                        completion(.alreadyInFavorite)
                        return
                    }
                    
                    retrievedFavorite.append(favorite)
                    
                    
                case .remove:
                    retrievedFavorite.removeAll { $0.login == favorite.login}
                }
                
            
                completion(save(followers: retrievedFavorite))
                
                
            case .failure(let error):
                completion(error)
            }
        }
        
    }
    
    
    static func retrieveFavorites(completion: @escaping (Result<[Follower], GFError>) -> Void) {
        
        guard let favorites = defaults.object(forKey: Keys.favorites) as? Data else {
            completion(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let favoritesData = try decoder.decode([Follower].self, from: favorites)
            completion(.success(favoritesData))
        } catch {
            completion(.failure(.unableToFavorite))
        }
    }
    
    static private func save(followers: [Follower]) -> GFError? {
        
        do {
            
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(followers)
            defaults.setValue(encodedFavorites, forKey: Keys.favorites)
            return nil
            
        } catch {
            return .unableToFavorite
        }
    }
    
}
