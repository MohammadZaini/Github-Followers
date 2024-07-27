//
//  ErrorMessage.swift
//  GithubFollowers
//
//  Created by Moe on 26/07/2024.
//

import Foundation

enum GFError: String, Error {
    case invalidUsername  = "This username created an invalid request. Plesae try again."
    case invalidResponse  = "Unable to complete your request. Please check your internet connection"
    case unableToComplete = "Invalid response from the server. Please try again."
    case invalidData      = "The data received from the server was invalid. Please try again."
}
