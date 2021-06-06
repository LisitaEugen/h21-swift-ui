//
//  H21App.swift
//  H21
//
//  Created by Evgheni Lisita on 21.12.20.
//

import SwiftUI

@main
struct H21App: App {
    @ObservedObject var viewModel: HabitsViewModel
    
    init() {
        ServiceLocator.shared.addService(service: FilePersister() as Persister)
        ServiceLocator.shared.addService(service: Notifications() as Notificator)
        viewModel = HabitsViewModel()
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
                viewModel.requestNotificaitonsPermisstions()
            }
        }
    }
}
