//
//  UserDefaults.swift
//  Calory
//
//  Created by Sahil Ak on 14/05/24.
//

import Foundation

extension UserDefaults {
    // Common group for sharing data with widgets
    static let group = UserDefaults(suiteName: Constants.groupIdentifier)
}
