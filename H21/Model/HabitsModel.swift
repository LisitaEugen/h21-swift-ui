//
//  HabitsModel.swift
//  H21
//
//  Created by Evgheni Lisita on 01.02.21.
//

import Foundation


class HabitsModel: ObservableObject {
    @Published var habits: [Habit] = Habit.data
    var persister: Persister? = ServiceLocator.shared.getService()
    
    
    
    func loadHabits() {
        persister?.load() { habits in
            self.habits = habits
        }
    }
    
    func saveHabits() {
        persister?.save(self.habits)
    }
}

protocol Persister {
    func load(_ completion: @escaping ([Habit]) -> Void)
    func save(_ habits: [Habit])
}

class HabitPersister: Persister {
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
            guard let data = try? Data(contentsOf: HabitPersister.fileUrl) else {
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
                let outFile = HabitPersister.fileUrl
                try data.write(to: outFile)
            } catch {
                fatalError("Cannot persist")
            }
        }
    }
}


final class ServiceLocator {
    private lazy var services: Dictionary<String, Any> = [:]
    
    private func typeName(_ some: Any) -> String {
        return (some is Any.Type) ?
            "\(some)" : "\(type(of: some))"
    }
    
    func addService<T>(service: T) {
        let key = typeName(T.self)
        services[key] = service
    }
    
    func getService<T>() -> T? {
        let key = typeName(T.self)
        return services[key] as? T
    }
    
    public static let shared = ServiceLocator()
}
