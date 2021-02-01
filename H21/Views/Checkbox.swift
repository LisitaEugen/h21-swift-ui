//
//  Checkbox.swift
//  H21
//
//  Created by Evgheni Lisita on 23.01.21.
//

import SwiftUI

struct Checkbox: View {
    @State var isChecked: Bool = false
    func toggle() { isChecked = !isChecked }
    var body: some View {
        Button(action: toggle){
            HStack{
                Image(systemName: isChecked ? "checkmark.square": "square")
            }
        }
        .buttonStyle(BorderlessButtonStyle())
    }
}

struct Checkbox_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Checkbox(isChecked: false)
            Checkbox(isChecked: true)
        }
    }
}

