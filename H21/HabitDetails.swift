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
    @State private var selectedMonth: SelectedMonth = .current
    @Environment(\.calendar) var calendar
    
    enum SelectedMonth {
        case current, previous
    }
    
    
    private var year: DateInterval {
        calendar.dateInterval(of: .year, for: Date())!
    }
    
    var body: some View {
        VStack {
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
                
                Section(header: Text("History")) {
                    Picker(selection: $selectedMonth, label:
                                   Text("Selected Month")
                                   , content: {
                                    Text(Date().previousMonth.monthAsString()).tag(SelectedMonth.previous)
                                    Text(Date().monthAsString()).tag(SelectedMonth.current)
                                   }).pickerStyle(SegmentedPickerStyle())
                    
                    MonthView(month: selectedMonth == .current ? Date() : Date().previousMonth, showHeader: false, content: dayView)
                }
            }
            .listStyle(InsetGroupedListStyle())
        }
        
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
    
    private func dayView(for calendarDate: Date) -> some View {
        let isAchievement = habit.achievements.filter {
            achievementDate in
            achievementDate.isSameDay(as: calendarDate)
        }.count != 0
        
        return Text("1")
            .hidden()
            .padding()
            .background(isAchievement ? habit.color : Color.white)
            .clipShape(Circle())
            .overlay(
                Text(String(self.calendar.component(.day, from: calendarDate)))
            )
    }
}

struct HabitDetails_Previews: PreviewProvider {
    
    static var previews: some View {
        var habit = Habit(title: "Title", motivation: "Motivation", color: .random)
        habit.reminderTime = Date()
        return HabitDetails_Screen(habit: .constant(habit))
    }
}
