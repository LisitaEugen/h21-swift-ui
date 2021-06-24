//
//  HabitFilePersister.swift
//  H21
//
//  Created by Evgheni Lisita on 06.02.21.
//

import Foundation

protocol Persister {
    func load<T: Codable>(_ completion: @escaping ([T]) -> Void)
    func save<T: Codable>(_ objects: [T])
}

class FilePersister: Persister {
    private static var documenrFolder: URL {
        FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.fox.H21")!
    }
    private static var fileUrl: URL {
        return documenrFolder.appendingPathComponent("persisted.data")
    }
    
    func load<T: Codable>(_ completion: @escaping ([T]) -> Void) {
        DispatchQueue.global(qos: .background).async {
            guard let data = try? Data(contentsOf: FilePersister.fileUrl) else {
                return
            }
            guard let objects = try? JSONDecoder().decode([T].self, from: data) else {
                fatalError("Can't decode saved scrum data.")
            }
            DispatchQueue.main.async {
                completion(objects)
            }
        }
    }
    
    func save<T: Codable>(_ objects: [T]) {
        DispatchQueue.global(qos: .background).async {
            guard let data = try? JSONEncoder().encode(objects) else {
                fatalError("Error envcoding data")
            }
            
            do {
                let outFile = FilePersister.fileUrl
                try data.write(to: outFile)
            } catch {
                fatalError("Cannot persist")
            }
        }
    }
}


