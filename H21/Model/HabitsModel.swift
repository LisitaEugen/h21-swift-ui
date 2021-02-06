//
//  HabitsModel.swift
//  H21
//
//  Created by Evgheni Lisita on 01.02.21.
//

import Foundation


class HabitsModel: ObservableObject, Persister {
    @Published var habits: [Habit] = Habit.data
    var persister: Persister? = ServiceLocator.shared.getService()
    
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
        persister?.load()
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
        persister?.save()
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let habits = self?.habits else {
                fatalError("Wrong self")
            }
            
            guard let data = try? JSONEncoder().encode(habits) else {
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

protocol Persister {
    func load()
    func save()
}

class HabitPersister: Persister {
    func load() {
        print("Load")
    }
    
    func save() {
        print("Save")
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
