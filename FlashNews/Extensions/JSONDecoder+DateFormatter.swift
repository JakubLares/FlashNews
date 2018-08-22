//
//  JSONDecoder+DateFormatter.swift
//  PocketReader
//
//  Created by Jakub Lares on 18.08.18.
//  Copyright © 2018 Jakub Lares. All rights reserved.
//

import Foundation

extension JSONDecoder {
    
    static let withDateFormatter: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601)
        return decoder
    }()
}
