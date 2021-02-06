//
//  Habit.swift
//  H21
//
//  Created by Evgheni Lisita on 17.09.19.
//  Copyright © 2019 Evgheni Lisita. All rights reserved.
//

//import Foundation
//import CoreData
import SwiftUI

struct Habit: Identifiable, Codable  {
    var id: UUID = UUID()
    var title: String
    var motivation: String
    var color: Color = .random
    var createdAt: Date = Date()
    var achievements: [Date] = []
}

extension Habit {
    static var demoHabit: Habit  {
        return Habit(title: "Read a 📖 daily", motivation: "Reading is essential for those who seek to rise above the ordinary. – Jim Rohn")
    }
}

extension Habit {
    static var data: [Habit] {
        [
            Habit.demoHabit,
            Habit.demoHabit,
            Habit.demoHabit,
            Habit.demoHabit,
        ]
    }
    
    static func new(from data: Data) -> Habit {
        return Habit(title: data.title, motivation: data.motivation, color: data.color)
    }
}

extension Habit {
    struct Data {
        var title: String = ""
        var motivation: String = ""
        var color: Color = .random
    }
    
    var data: Data {
        return Data(title: title, motivation: motivation, color: color)
    }
    
    mutating func update(from data: Data) {
        self.title = data.title
        self.motivation = data.motivation
        self.color = data.color
    }
}

