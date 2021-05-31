//
//  ContentView.swift
//  H21
//
//  Created by Evgheni Lisita on 21.12.20.
//

import SwiftUI

struct Habits_Screen: View {
    @EnvironmentObject var habitsModel: HabitsViewModel
    @State var addHabitPresented = false
    @State var newHabitData = Habit.Data()
    @Environment(\.scenePhase) private var scenePhase
    let saveAction: () -> Void
    
    var body: some View {
        VStack {
            Days()
            List{
                ForEach(habitsModel.habits, id: \.id) { habit in
                    NavigationLink(
                        destination: HabitDetails_Screen(habit: binding(for: habit))
                    ){
                        HabitRow(enabledAchievements: habit.enabledAchievements, habit: habit)
                    }
                }
                .onDelete(perform: deleteHabits)
            }
            //            .listStyle(PlainListStyle())
            Spacer()
        }
        .navigationBarTitle(Text("Habits"))
        .navigationBarItems(trailing: Button(action: {
            addHabitPresented = true
        }) {
            Image(systemName: "plus")
        })
        .sheet(isPresented: $addHabitPresented) {
            NavigationView {
                AddHabit_Screen(habitData: $newHabitData)
                    .navigationBarItems(leading: Button("Dismiss") {
                        addHabitPresented = false
                    }, trailing: Button("Add") {
                        let newHabit = Habit.new(from: newHabitData)
                        habitsModel.habits.append(newHabit)
                        newHabitData = Habit.Data()
                        addHabitPresented = false
                    })
            }
        }
        .onChange(of: scenePhase) { phase in
            saveAction()
        }
    }
    
    private func binding(for habit: Habit) -> Binding<Habit> {
        guard let habitIndex = habitsModel.habits.firstIndex(where: {$0.id == habit.id}) else {
            fatalError("Something went wrong!")
        }
        return $habitsModel.habits[habitIndex]
    }
    
    func deleteHabits(at offsets: IndexSet) {
        habitsModel.habits.remove(atOffsets: offsets)
    }
}

struct HabitRow: View {
    @State var enabledAchievements = Array(repeating: false, count: 6)
    @EnvironmentObject var habitsModel: HabitsViewModel
    var habit: Habit
    
    var body: some View {
        let (status, icon) = habitsModel.progress(for: habit).toUI()
        
        return
            VStack(spacing: 0) {
                HStack {
                    Checkbox(isChecked: $enabledAchievements[0], color: habit.color)
                        .frame(maxWidth: .infinity)
                    Checkbox(isChecked: $enabledAchievements[1], color: habit.color)
                        .frame(maxWidth: .infinity)
                    Checkbox(isChecked: $enabledAchievements[2], color: habit.color)
                        .frame(maxWidth: .infinity)
                    Checkbox(isChecked: $enabledAchievements[3], color: habit.color)
                        .frame(maxWidth: .infinity)
                    Checkbox(isChecked: $enabledAchievements[4], color: habit.color)
                        .frame(maxWidth: .infinity)
                    Checkbox(isChecked: $enabledAchievements[5], color: habit.color)
                        .frame(maxWidth: .infinity)
                }
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                HStack {
                    Text(habit.title)
                        .font(.title3)
                    Spacer()
                }
                .padding(EdgeInsets(top: 10, leading: 15, bottom: 0, trailing: 0))
                HStack {
                    if let reminderTime = habit.reminderTime {
                        Label(Date.getFormattedDate(date: reminderTime, format: "h:mm a"), systemImage: "alarm.fill")
                            .font(.system(size: 15, weight: .bold))
                            .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 10))
                            .foregroundColor(Color.white)
                            .background(habit.color)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.white, lineWidth: 2))
                    }
                    Spacer()
                    Label(status, systemImage: icon)
                        .font(.system(size: 15, weight: .bold))
                        .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 10))
                        .foregroundColor(Color.white)
                        .background(habit.color)
                        .clipShape(Capsule())
                        .overlay(Capsule().stroke(Color.white, lineWidth: 2))
                    
                }
                .padding()
            }
            .onChange(of: enabledAchievements) { newEnabledAchievements in
                handleChanges(for: newEnabledAchievements)
            }
    }
    
    private func handleChanges(for achievements: [Bool]) {
        habitsModel.onChange(achievements: enabledAchievements, for: habit)
    }
}


struct Days: View {
    typealias Day = (number: String, day: String)
    var days: [Day] {
        Date.currentRangeDates.map({ date in
            let splittedDate = date.short().split(separator: " ")
            return (number: String(splittedDate[0]), day: String(splittedDate[1]))
        })
    }
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(days, id: \.number) { (number, day) in
                VStack {
                    Text(day)
                    Text(number)
                        .fontWeight(.bold)
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 35))
    }
}


struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            Habits_Screen() {}
                .environmentObject(HabitsViewModel())
        }
        Group {
            HabitRow(enabledAchievements: Habit.demoHabit.enabledAchievements, habit: Habit.demoHabit)
                .environmentObject(HabitsViewModel())
        }
        
    }
}
