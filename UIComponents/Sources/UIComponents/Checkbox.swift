//
//  Checkbox.swift
//  H21
//
//  Created by Evgheni Lisita on 23.01.21.
//

import SwiftUI

@available(iOS 13.0, *)
public struct Checkbox: View {
    var isChecked: Binding<Bool>
    
    public init(isChecked: Binding<Bool>) {
        self.isChecked = isChecked
    }
    
    public var body: some View {
        Button(action: { isChecked.wrappedValue.toggle() }){
            HStack{
                Image(systemName: self.isChecked.wrappedValue ? "checkmark.circle.fill": "circle")
            }
        }
        .buttonStyle(BorderlessButtonStyle())
    }
}

@available(iOS 13.0.0, *)
struct Checkbox_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Checkbox(isChecked: .constant(false))
            Checkbox(isChecked: .constant(true))
        }
    }
}

