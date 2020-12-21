//
//  HabitDetails.swift
//  H21
//
//  Created by Evgheni Lisita on 21.12.20.
//

import SwiftUI

struct HabitDetails_Screen: View {
    var description: String
    var motivation: String

    var body: some View {
        VStack {
            Text(description)
                .padding()
            Text(motivation)
                .padding()
        }
    }
}

struct HabitDetails_Previews: PreviewProvider {
    static var previews: some View {
        HabitDetails_Screen(description: "Description", motivation: "Motivation")
    }
}
