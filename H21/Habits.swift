//
//  ContentView.swift
//  H21
//
//  Created by Evgheni Lisita on 21.12.20.
//

import SwiftUI

struct Habits_Screen: View {
    @EnvironmentObject var habitsModel: HabitsModel
    @State var addHabitPresented = false
    @State var newHabitData = Habit.Data()
    
    var body: some View {
        VStack {
            Days()
            List(habitsModel.habits, id: \.title) { habit in
                HabitRow(habit: binding(for: habit))
                NavigationLink(
                    destination: HabitDetails_Screen(habit: binding(for: habit))
                ) {
                    EmptyView()
                }.hidden().frame(width: 0)
            }
            .background(Color.red)
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
                        
                        addHabitPresented = false
                    })
            }
        }
    }
    
    private func binding(for habit: Habit) -> Binding<Habit> {
        guard let habitIndex = habitsModel.habits.firstIndex(where: {$0.id == habit.id}) else {
            fatalError("Something went wrong!")
        }
        return $habitsModel.habits[habitIndex]
    }
}

struct HabitRow: View {
    @Binding var habit: Habit
        
    var body: some View {
        VStack{
            HStack {
                Checkbox(isChecked: habit.enabledAchievements[0])
                    .padding()
                Checkbox(isChecked: habit.enabledAchievements[1])
                    .padding()
                Checkbox(isChecked: habit.enabledAchievements[2])
                    .padding()
                Checkbox(isChecked: habit.enabledAchievements[3])
                    .padding()
                Checkbox(isChecked: habit.enabledAchievements[4])
                    .padding()
                Checkbox(isChecked: habit.enabledAchievements[5])
                    .padding()
            }
            HStack {
                Text(habit.title)
                Spacer()
                Text("\(habit.getProgressPercentage())%")
                    .font(.headline)
            }
            .padding()
        }
        .cornerRadius(10.0)
        //        .padding()
        //        .border(Color.black, width: 3)
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
                .padding()
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            Habits_Screen()
        }
    }
}
