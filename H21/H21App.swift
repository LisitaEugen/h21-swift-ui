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
        resetUITableViewAppearance()
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
                viewModel.loadHabits() {}
                viewModel.requestNotificaitonsPermisstions()
            }
        }
    }
}

extension H21App {
    func resetUITableViewAppearance() {
        //        UITableView.appearance().separatorStyle = .none
        //        UITableView.appearance().separatorInset = .zero
        //        UITableView.appearance().showsHorizontalScrollIndicator = false
        //        UITableView.appearance().showsVerticalScrollIndicator = false
        //        UITableView.appearance().layoutMargins = .zero
        //        UITableView.appearance().contentInset = .zero
        //        UITableView.appearance().contentOffset = .zero
        UITableViewCell.appearance().selectionStyle = .none
        UITableViewCell.appearance().separatorInset = .zero
        UITableViewCell.appearance().layoutMargins = .zero
        //        UITableViewHeaderFooterView.appearance().tintColor = .clear
    }
}
