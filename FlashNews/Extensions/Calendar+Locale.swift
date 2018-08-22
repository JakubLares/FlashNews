//
//  Calendar+Locale.swift
//  PocketReader
//
//  Created by Jakub Lares on 20.08.18.
//  Copyright © 2018 Jakub Lares. All rights reserved.
//

import Foundation

extension Calendar {
    
    static let withLocale: Calendar = {
        var calendar = Calendar.current
        calendar.locale = Locale.current
        return calendar
    }()
}
