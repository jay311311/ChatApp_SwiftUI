//
//  Date+.swift
//  ChatApp_SwiftUI
//
//  Created by Jooeun Kim on 2024-06-11.
//

import Foundation

extension Date {
    
    init?(year: Int, month: Int, day: Int) {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        
        guard let date = Calendar.current.date(from: components) else {
            return nil
        }
        self = date
    }
    
    var toChatTime: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en-CA")
        formatter.dateFormat = "a h:mm"
        return formatter.string(from: self)
    }
    
    
    var toChatDataKey: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en-CA")
        formatter.dateFormat = "yyyy.MM.dd E"
        return formatter.string(from: self)
    }
    
}

extension String {
    
    var toChatDate: Date? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en-CA")
        formatter.dateFormat = "yyyy.MM.dd E"
        return formatter.date(from: self)
    }
}
