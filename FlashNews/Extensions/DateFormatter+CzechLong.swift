//
//  DateFormatter+CzechLong.swift
//  PocketReader
//
//  Created by Jakub Lares on 20.08.18.
//  Copyright © 2018 Jakub Lares. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    static let czechLong: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm dd.MMMM YYYY"
        formatter.locale = Locale(identifier: "cs_CZ")
        return formatter
    }()
}
