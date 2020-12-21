//
//  AddHabit.swift
//  H21
//
//  Created by Evgheni Lisita on 21.12.20.
//

import SwiftUI

struct AddHabit_Screen: View {
    @State var description: String = ""
    @State var motivation: String = ""
    
    var body: some View {
        VStack {
            TextField("Description", text: $description)
                .padding()
            TextField("Motivation", text: $motivation)
                .padding()
        }
    }
}

struct AddHabit_Previews: PreviewProvider {
    static var previews: some View {
        AddHabit_Screen()
    }
}
