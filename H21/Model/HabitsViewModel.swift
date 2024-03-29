//
//  HabitsModel.swift
//  H21
//
//  Created by Evgheni Lisita on 01.02.21.
//

import Foundation

enum Progress {
    case rocking, onTrack, needsImprovement
    
    func toUI() -> (String, String) {
        switch self {
        case .rocking:
            return ("Rocking", "arrow.up.right.circle.fill")
        case .onTrack:
            return ("On track","arrow.forward.circle.fill")
        case .needsImprovement:
            return ("Needs improvement","arrow.down.forward.circle.fill")
        }
    }
}

class HabitsViewModel: ObservableObject {
    @Published var habits: [Habit] = Habit.data
    var persister: Persister? = ServiceLocator.shared.getService()
    var notifications: Notifications? = ServiceLocator.shared.getService()
    
    func progress(for habit: Habit) -> Progress {
        // if in last 2 months > 100% from 21 -> rocking 🚀 😍 👏 🐆 􀲯 􀑓  􀱀 􀱂 􀂄
        //                     >= 50% from 21 -> ontrack ✅ 🙂 👌🐇 􀊀 􀙙  􀰓 􀄍 􀁼
        //            <= 50% from 21 -> needsImprovement 🔨 😐 🤞🐢 􀊂 􀝢   􀂉 􀄙 􀂈
        
        
        // TODO: CHECK if filers properly
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
        
        let achievementsPercentage = last2MonthAchievements.count > 0 ? Int((Double(last2MonthAchievements.count) / 21.0) * 100.0) : 0
        
        var progress: Progress
        if achievementsPercentage >= 100 {
            progress = .rocking
        } else if achievementsPercentage >= 50 {
            progress = .onTrack
        } else {
            progress = .needsImprovement
        }
        
        return progress
    }
    
    func onChange(achievements enabledAchievements: [Bool], for habit: Habit) {
        var updatedHabit = habit
        updatedHabit.enabledAchievements = enabledAchievements
        habits = habits.map { $0.id != habit.id ? $0 : updatedHabit }
    }
}


extension HabitsViewModel {
    func loadHabits(_ completion: @escaping () -> Void) {
        
        func onLoad(_ habits: [Habit]) {
            self.habits = habits
            completion()
        }
        
        persister?.load(onLoad(_:))
    }
    
    func saveHabits() {
        persister?.save(self.habits)
        print("save")
        print(habits)
    }
}

extension HabitsViewModel {
    func requestNotificaitonsPermisstions() {
        notifications?.requestPermissions()
    }
    
    func scheduleNotifications(for habit: Habit) {
        guard let reminderTime = habit.reminderTime else {
            debugPrint("No time for reminder!")
            return
        }
        
        let title = habit.title
        let message = habit.motivation
        let notificationId = habit.id.uuidString
        
        notifications?.scheduleNotifications(with: notificationId, title, message, for: reminderTime)
    }
    
    func removeNotifications(for habit: Habit) {
        let notificationId = habit.id.uuidString
        notifications?.removeNotifications(with: notificationId)
    }
}
