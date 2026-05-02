//
//  Item.swift
//  Task Master
//
//  Created by Ty Janik on 5/2/26.
//

import Foundation
import SwiftData

enum FrequencyUnit: Codable {
    case Daily
    case Weekly
    case Monthly
    case Annually
}

struct Frequency: Codable {
    var value: Int
    var unit: FrequencyUnit
}

@Model
final class Task {
    var name: String
    var dueDate: Date
    var frequency: Frequency
    
    init() {
        self.name = ""
        self.dueDate = Date()
        self.frequency = Frequency(value: 1, unit: .Daily)
    }
    
    init(name: String, dueDate: Date) {
        self.name = name
        self.dueDate = dueDate
        self.frequency = Frequency(value: 1, unit: .Daily)
    }
}
