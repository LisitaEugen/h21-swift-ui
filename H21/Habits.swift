//
//  ContentView.swift
//  H21
//
//  Created by Evgheni Lisita on 21.12.20.
//

import SwiftUI

struct Habits_Screen: View {
    let habits = Array(0...10)
    @State var toggle = true
    
    var body: some View {
        VStack {
            List(habits, id: \.self) { item in
                HabitRow(toggle0: $toggle, toggle1: $toggle, toggle2: $toggle, toggle3: $toggle, toggle4: $toggle)
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
        
    var body: some View {
        VStack{
            HStack {
                Toggle("", isOn: $toggle0)
                Toggle("", isOn: $toggle1)
                Toggle("", isOn: $toggle2)
                Toggle("", isOn: $toggle3)
                Toggle("", isOn: $toggle4)
            }
            HStack {
                Text("Loooooooooooooooooooooooooooong tiiiiiiitle")
                Text("50%")
            }
        }
        .cornerRadius(10.0)
        .padding()
        .border(Color.black, width: 3)
    }
}


struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            Habits_Screen()
        }
    }
}
