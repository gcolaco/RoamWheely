//
//  PersistenceManager.swift
//  RoamWheely
//
//  Created by Gustavo Colaço on 17/07/21.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

enum PersistenceManager {
    
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let options = "options"
    }
    
    
    static func updateWith(option: Option, actionType: PersistenceActionType, completed: @escaping (RWErrorMessage?) -> Void) {
        retrieveOptions { result in
            switch result {
            case .success(var options):
                
                switch actionType {
                case .add:
                    
                    options.append(option)
                    
                case .remove:
                    options.removeAll { $0.optionName == option.optionName}
                }
                
                completed(save(options: options))

            case .failure(let error):
                completed(error)
            }
        }
    }
    
    
    static func retrieveOptions(completed: @escaping (Result<[Option], RWErrorMessage>) -> Void) {
        guard let optionsData = defaults.object(forKey: Keys.options) as? Data else {
            completed(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let options = try decoder.decode([Option].self, from: optionsData)
            completed(.success(options))
        } catch {
            completed(.failure(.unableToSaveOption))
        }
    }
    
    
    static func save(options: [Option]) -> RWErrorMessage? {
        do {
            let encoder = JSONEncoder()
            let encondedOptions  = try encoder.encode(options)
            defaults.setValue(encondedOptions, forKey: Keys.options)
            return nil
        } catch {
            return .unableToSaveOption
        }
        
    }
    
}
