//
//  HabitsModel.swift
//  H21
//
//  Created by Evgheni Lisita on 01.02.21.
//

import Foundation


class HabitsModel: ObservableObject {
    @Published var habits: [Habit] = Habit.data
    
    private static var documenrFolder: URL {
        do {
            return try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        } catch {
            fatalError("Cannot find docs folder!!!")
        }
    }
    private static var fileUrl: URL {
        return documenrFolder.appendingPathComponent("scrums.data")
    }
    
    func load() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let data = try? Data(contentsOf: HabitsModel.fileUrl) else {
                #if DEBUG
                DispatchQueue.main.async {
                    self?.habits = Habit.data
                }
                #endif
                return
            }
            guard let habits = try? JSONDecoder().decode([Habit].self, from: data) else {
                fatalError("Can't decode saved scrum data.")
            }
            DispatchQueue.main.async {
                self?.habits = habits
            }
        }
    }
    
    func save() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let scrums = self?.habits else {
                fatalError("Wrong self")
            }
            
            guard let data = try? JSONEncoder().encode(scrums) else {
                fatalError("Error envcoding data")
            }
            
            do {
                let outFile = HabitsModel.fileUrl
                try data.write(to: outFile)
            } catch {
                fatalError("Cannot persist")
            }
        }
    }
}
