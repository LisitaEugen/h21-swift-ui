//
//  HabitDetails.swift
//  H21
//
//  Created by Evgheni Lisita on 21.12.20.
//

import SwiftUI

struct HabitDetails_Screen: View {
    var habit: Habit
    
    var body: some View {
        List {
            Section(header: Text("Habit info")) {
                Label(habit.title, systemImage: "signature")
                Label(habit.motivation, systemImage: "sunrise")
                HStack {
                    Label("Color", systemImage: "paintpalette")
                    Spacer()
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(habit.color)
                }
            }
            if let reminderTime = habit.reminderTime {
                Section(header: Text("Reminder")) {
                    HStack {
                        Label("Reminde me daily at", systemImage: "alarm")
                        Spacer()
                        Text(Date.getFormattedDate(date: reminderTime, format: "HH:MM"))
                            .font(.headline)
                    }
                }
            }
            
        }
        .listStyle(InsetGroupedListStyle())
    }
}

struct HabitDetails_Previews: PreviewProvider {
    
    static var previews: some View {
        var habit = Habit(title: "Title", motivation: "Motivation", color: .random)
        habit.reminderTime = Date()
        return HabitDetails_Screen(habit: habit)
    }
}
