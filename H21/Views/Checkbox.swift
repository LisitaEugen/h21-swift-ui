//
//  Checkbox.swift
//  H21
//
//  Created by Evgheni Lisita on 23.01.21.
//

import SwiftUI

struct Checkbox: View {
    @Binding var isChecked: Bool
    func toggle() { isChecked = !isChecked }
    var body: some View {
        Button(action: toggle){
            HStack{
                Image(systemName: isChecked ? "checkmark.circle.fill": "circle")
            }
        }
        .buttonStyle(BorderlessButtonStyle())
    }
}

struct Checkbox_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Checkbox(isChecked: .constant(false))
            Checkbox(isChecked: .constant(true))
        }
    }
}

