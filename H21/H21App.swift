//
//  H21App.swift
//  H21
//
//  Created by Evgheni Lisita on 21.12.20.
//

import SwiftUI

@main
struct H21App: App {
    @ObservedObject var viewModel = HabitsModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                Habits_Screen() {
                    viewModel.save()
                }
                .environmentObject(viewModel)
            }
            .onAppear() {
                viewModel.load()
            }
        }
    }
}
