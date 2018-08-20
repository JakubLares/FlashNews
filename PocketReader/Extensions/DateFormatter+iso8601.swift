//
//  DateFormatter+iso8601Full.swift
//  PocketReader
//
//  Created by Jakub Lares on 18.08.18.
//  Copyright © 2018 Jakub Lares. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    static let iso8601: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        return formatter
    }()
}
