//
//  HabitFilePersister.swift
//  H21
//
//  Created by Evgheni Lisita on 06.02.21.
//

import Foundation

protocol Persister {
    func load(_ completion: @escaping ([Habit]) -> Void)
    func save(_ habits: [Habit])
}

class HabitFilePersister: Persister {
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
    
    func load(_ completion: @escaping ([Habit]) -> Void) {
        DispatchQueue.global(qos: .background).async {
            guard let data = try? Data(contentsOf: HabitFilePersister.fileUrl) else {
                return
            }
            guard let habits = try? JSONDecoder().decode([Habit].self, from: data) else {
                fatalError("Can't decode saved scrum data.")
            }
            DispatchQueue.main.async {
                completion(habits)
            }
        }
    }
    
    func save(_ habits: [Habit]) {
        DispatchQueue.global(qos: .background).async {
            guard let data = try? JSONEncoder().encode(habits) else {
                fatalError("Error envcoding data")
            }
            
            do {
                let outFile = HabitFilePersister.fileUrl
                try data.write(to: outFile)
            } catch {
                fatalError("Cannot persist")
            }
        }
    }
}


