//
//  Date+Extensions.swift
//  Cinema
//
//  Created by Mohsin Ali Ayub on 07.09.23.
//

import Foundation

extension Date {
    
    /// Convert date to String with your provided format.
    ///
    /// Convert the date with your provided date format. For example, "MMM YYYY" will
    /// convert the date to "January 2023" etc.
    /// - Parameter format: The format string. For example, "MMM YYYY".
    /// - Returns: String based on the format.
    func format(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        return formatter.string(from: self)
    }
}
