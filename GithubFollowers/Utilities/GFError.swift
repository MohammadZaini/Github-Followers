//
//  GFError.swift
//  GithubFollowers
//
//  Created by Moe on 29/07/2024.
//

import Foundation

enum GFError: String, Error {
    case invalidUsername   = "This username created an invalid request. Plesae try again."
    case invalidResponse   = "Unable to complete your request. Please check your internet connection"
    case unableToComplete  = "Invalid response from the server. Please try again."
    case invalidData       = "The data received from the server was invalid. Please try again."
    case unableToFavorite  = "There was an error favoriting this user. Please try again."
    case alreadyInFavorite = "You've already favorited This user!."
}
