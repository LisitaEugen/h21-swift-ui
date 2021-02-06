//
//  HabitsModel.swift
//  H21
//
//  Created by Evgheni Lisita on 01.02.21.
//

import Foundation


class HabitsModel: ObservableObject {
    @Published var habits: [Habit] = Habit.data
}
