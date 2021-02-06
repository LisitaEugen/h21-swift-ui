//
//  H21App.swift
//  H21
//
//  Created by Evgheni Lisita on 21.12.20.
//

import SwiftUI

@main
struct H21App: App {
    @ObservedObject var viewModel: HabitsModel
    
    init() {
        ServiceLocator.shared.addService(service: HabitPersister() as Persister)
        viewModel = HabitsModel()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                Habits_Screen() {
                    viewModel.saveHabits()
                }
                .environmentObject(viewModel)
            }
            .onAppear() {
                viewModel.loadHabits()
            }
        }
    }
}
