//
//  HabitDetails.swift
//  H21
//
//  Created by Evgheni Lisita on 21.12.20.
//

import SwiftUI

struct HabitDetails_Screen: View {
    @Binding var habit: Habit
    @State private var data: Habit.Data = Habit.Data()
    @State private var isPresented: Bool = false
    
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
        .navigationBarItems(trailing: Button("Edit") {
            isPresented = true
            data = habit.data
        })
        .fullScreenCover(isPresented: $isPresented) {
            NavigationView {
                AddHabit_Screen(habitData: $data)
                    .navigationTitle("Edit Habit")
                    .navigationBarItems(leading: Button("Cancel") {
                        isPresented = false
                    }, trailing: Button("Done") {
                        isPresented = false
                        habit.update(from: data)
                    })
            }
        }
    }
}

struct HabitDetails_Previews: PreviewProvider {
    
    static var previews: some View {
        var habit = Habit(title: "Title", motivation: "Motivation", color: .random)
        habit.reminderTime = Date()
        return HabitDetails_Screen(habit: .constant(habit))
    }
}
