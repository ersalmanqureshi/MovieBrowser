//
//  FormatDate.swift
//  Movie Browser
//
//  Created by Salman Qureshi on 5/28/18.
//  Copyright © 2018 Salman Qureshi. All rights reserved.
//

import Foundation

class FormatDate {
    static let instance = DateFormatter()
    
    static func format(date: String) -> String {
        instance.dateFormat = "yyyy-MM-dd"
        
        guard let date = instance.date(from: date) else { fatalError("Can't format the date") }
        instance.dateFormat = "MMM dd, yyyy"
        
        return instance.string(from: date)
    }
}
