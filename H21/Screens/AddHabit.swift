//
//  AddHabit.swift
//  H21
//
//  Created by Evgheni Lisita on 21.12.20.
//

import SwiftUI

struct AddHabit_Screen: View {
    @Binding var habitData: Habit.Data
    
    var body: some View {
        List {
            Section(header: Text("Habit info")) {
                TextField("Title", text: $habitData.title)
                TextField("Motivation", text: $habitData.motivation)
                ColorPicker("Color", selection: $habitData.color)
                    .accessibilityLabel(Text("Color picker"))
            }
            Section(header: Text("Reminder")) {
                Toggle("Remind me daily", isOn: $habitData.reminderOn)
                if habitData.reminderOn {
                    DatePicker("at", selection: $habitData.reminderTime, displayedComponents: .hourAndMinute)
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
    }
}

struct AddHabit_Previews: PreviewProvider {
    static var previews: some View {
        AddHabit_Screen(habitData: .constant(Habit.Data(title: "Title", motivation: "Motivation", color: .random)))
    }
}
