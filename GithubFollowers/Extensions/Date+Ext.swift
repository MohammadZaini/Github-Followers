//
//  Date+Ext.swift
//  GithubFollowers
//
//  Created by Moe on 31/07/2024.
//

import Foundation

extension Date {
    
    func convertToMonthYearFormat() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: self)
    }
}
