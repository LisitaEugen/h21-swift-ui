//
//  ContentView.swift
//  H21
//
//  Created by Evgheni Lisita on 21.12.20.
//

import SwiftUI

struct Habits_Screen: View {
    @EnvironmentObject var habitsModel: HabitsModel
    @State var toggle = true
    @State var addHabitPresented = false
    @State var newHabitData = Habit.Data()
    
    var body: some View {
        VStack {
            Days()
                .background(Color.blue)
            List(habitsModel.habits, id: \.title) { habit in
                HabitRow(toggle0: $toggle, toggle1: $toggle, toggle2: $toggle, toggle3: $toggle, toggle4: $toggle, toggle5: $toggle, title: habit.title)
                NavigationLink(
                    destination: HabitDetails_Screen(description: "", motivation: "")) {
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
}

struct HabitRow: View {
    @Binding var toggle0: Bool
    @Binding var toggle1: Bool
    @Binding var toggle2: Bool
    @Binding var toggle3: Bool
    @Binding var toggle4: Bool
    @Binding var toggle5: Bool
    
    var title: String
    
    var body: some View {
        VStack{
            HStack {
                Checkbox(isChecked: toggle0)
                    .padding()
                Checkbox(isChecked: toggle1)
                    .padding()
                Checkbox(isChecked: toggle2)
                    .padding()
                Checkbox(isChecked: toggle3)
                    .padding()
                Checkbox(isChecked: toggle4)
                    .padding()
                Checkbox(isChecked: toggle5)
                    .padding()
            }
            HStack {
                Text(title)
                Text("50%")
            }
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
