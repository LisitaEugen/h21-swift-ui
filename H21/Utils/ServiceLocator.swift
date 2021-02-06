//
//  ServiceLocator.swift
//  H21
//
//  Created by Evgheni Lisita on 06.02.21.
//

import Foundation

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
