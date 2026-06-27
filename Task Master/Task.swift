//
//  Item.swift
//  Task Master
//
//  Created by Ty Janik on 5/2/26.
//

import Foundation
import SwiftData

enum FrequencyUnit: String, Codable, CaseIterable, Identifiable {
    case Days
    case Weeks
    case Months
    case Years

    var id: Self { self }
}

struct Frequency: Codable {
    var value: Int?
    var unit: FrequencyUnit?
}

@Model
final class Task: Identifiable {
    var id = UUID()
    var name: String
    var dueDate: Date
    var frequency: Frequency

    init() {
        self.name = ""
        self.dueDate = Date()
        self.frequency = Frequency()
    }

    init(name: String, dueDate: Date) {
        self.name = name
        self.dueDate = dueDate
        self.frequency = Frequency()
    }
}
