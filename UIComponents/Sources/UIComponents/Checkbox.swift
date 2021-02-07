//
//  Checkbox.swift
//  H21
//
//  Created by Evgheni Lisita on 23.01.21.
//

import SwiftUI

@available(iOS 13.0, *)
public struct Checkbox: View {
    @Binding var isChecked: Bool
    
    public init(isChecked: Binding<Bool>) {
        self._isChecked = isChecked
    }
    
    public var body: some View {
        Button(action: { isChecked.toggle() }){
            HStack{
                Image(systemName: self.isChecked ? "checkmark.circle.fill": "circle")
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

