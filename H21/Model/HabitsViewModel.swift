//
//  HabitsModel.swift
//  H21
//
//  Created by Evgheni Lisita on 01.02.21.
//

import Foundation

enum Progress {
    case rocking, onTrack, needsImprovement
    
    func toIconString() -> String {
        switch self {
        case .rocking:
            return "arrow.up.right.circle.fill"
        case .onTrack:
            return "arrow.forward.circle.fill"
        case .needsImprovement:
            return "arrow.down.forward.circle.fill"
        }
    }
}

class HabitsViewModel: ObservableObject {
    @Published var habits: [Habit] = Habit.data
    var persister: Persister? = ServiceLocator.shared.getService()
    
    func loadHabits() {
        persister?.load() { habits in
            self.habits = habits
        }
    }
    
    func saveHabits() {
        persister?.save(self.habits)
    }
    
    func progressIcon(for habit: Habit) -> String {
        // if in last 2 months > 100% from 21 -> rocking 🚀 😍 🐆 􀲯 􀑓  􀱀 􀱂 􀂄
        //                     >= 50% from 21 -> ontrack ✅ 🙂 🐇 􀊀 􀙙  􀰓 􀄍 􀁼
        //            <= 50% from 21 -> needsImprovement 🔨 😐 🐢 􀊂 􀝢   􀂉 􀄙 􀂈
        
        let last2MonthAchievements = habit.achievements.filter {
            date in
            let order = Calendar.current.compare(Date().previousMonth, to: date, toGranularity: .day)
            
            switch order {
            case .orderedDescending:
                return false
            case .orderedAscending:
                return true
            case .orderedSame:
                return true
            }
            
        }
        
        print("last2MonthAchievements")
        print(last2MonthAchievements)
        
        let achievementsPercentage = last2MonthAchievements.count > 0 ? Int((Double(last2MonthAchievements.count) / 21.0) * 100.0) : 0
        
        var progress: Progress
        if achievementsPercentage >= 100 {
            progress = .rocking
        } else if achievementsPercentage >= 50 {
            progress = .onTrack
        } else {
            progress = .needsImprovement
        }
        
        
        return progress.toIconString()
    }
    
    
}
