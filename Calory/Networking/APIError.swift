//
//  APIError.swift
//  Calory
//
//  Created by Sahil Ak on 06/05/24.
//

import Foundation

// States of different errors related to networking data fetch
enum APIError: Error {
    case invalidURL
    case invalidData
}
