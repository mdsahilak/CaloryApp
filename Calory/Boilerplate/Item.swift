//
//  Item.swift
//  Calory
//
//  Created by Sahil Ak on 06/05/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
