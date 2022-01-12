//
//  Date+Extension.swift
//  JobGetTest
//
//  Created by Precup Aurel Dan on 12/01/2022.
//

import Foundation

extension Date {
    
    /// The date formatted as a day - month - year string
    var dayPrettyString: String { formatted(format: "DD MMMM yyyy") }
    
    /// The date formatted as a month - day - year string
    var dayString: String { formatted(format: "MM-dd-yyyy") }
    
    /// The date formatted as hour: minutes string
    var timeString: String { formatted(format: "HH:mm") }
    
    /// Formts the date and returns a string
    /// - Parameter format: The format
    /// - Returns: The resulting string
    func formatted(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = .current
        return formatter.string(from: self)
    }
}
