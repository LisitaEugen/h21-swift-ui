//
//  HabitsModel.swift
//  H21
//
//  Created by Evgheni Lisita on 01.02.21.
//

import Foundation
import Persistance


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
}
