//
//  HabitsModel.swift
//  H21
//
//  Created by Evgheni Lisita on 01.02.21.
//
import SwiftUI

struct Habit: Identifiable, Codable  {
    var id: UUID = UUID()
    var title: String
    var motivation: String
    var color: Color = .random
    var createdAt: Date = Date()
    var reminderTime: Date?
    var achievements: [Date] = []
    var enabledAchievements: [Bool] = [false, true, false, true, false, true] {
        didSet {
            handleChanges(for: enabledAchievements)
        }
    }
}

// init enabledAchievements by iterationg throug current interval and matching with acievements array
// add/remove achievements by listening on changes of current enabledAchievements

extension Habit {
    static var demoHabit: Habit  {
        var habit = Habit(title: "Read a 📖 daily", motivation: "Reading is essential for those who seek to rise above the ordinary. – Jim Rohn")
        habit.achievements = [Date(), Date.yesterday, Date.yesterday.dayBefore, Date().previousMonth]
        return habit
    }
}

extension Habit {
    static var data: [Habit] {
        [
            Habit.demoHabit,
        ]
    }
    
    static func new(from data: Data) -> Habit {
        return Habit(title: data.title, motivation: data.motivation, color: data.color, reminderTime: data.reminderOn ? data.reminderTime: nil)
    }
}

extension Habit {
    struct Data {
        var title: String = ""
        var motivation: String = ""
        var color: Color = .random
        var reminderOn: Bool = true {
            didSet {
                if reminderOn {
                    reminderTime = Date()
                }
            }
        }
        var reminderTime: Date = Date()
    }
    
    struct Achievements {
        static func enabledAchievements(forHabit habit: Habit) -> [Bool]{
            var enabledAchievements = [Bool]()
            
            for date in Date.currentRangeDates {
                let enabled = habit.isAchievementEnabled(forDate: date)
                enabledAchievements.append(enabled)
            }
            
            return enabledAchievements
        }
        
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

extension Habit {
    func isAchievementEnabled(forDate date: Date) -> Bool {
        for achievement in achievements {
            if achievement == date {
                return true
            }
        }
        
        return false
    }
    
    func getProgressPercentage() -> Int {
        achievements.count > 0 ? Int((Double(achievements.count) / 21.0) * 100.0) : 0
    }
    
    mutating func handleChanges(for enabledAchievements: [Bool]) {
        let dates = Date.currentRangeDates
        
        for (index, enabled) in enabledAchievements.enumerated() {
            if enabled {
                addAchievement(for: dates[index])
            } else {
                removeAchievement(for: dates[index])
            }
        }
        print(achievements)
    }
    
    mutating func addAchievement(for date: Date) {
        guard !achievements.contains(date) else {
            return
        }
        
        achievements.append(date)
    }
    
    mutating func removeAchievement(for date: Date) {
        guard let indexForRemoval = achievements.firstIndex(of: date) else {
            return
        }
        
        achievements.remove(at: indexForRemoval)
    }
}

