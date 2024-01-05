//
//  CoreDataManager.swift
//  WeatherApp-MVVM
//
//  Created by Eken Özlü on 5.01.2024.
//

import UIKit
import CoreData

final class CoreDataManager {
    
    public static let shared = CoreDataManager()
    
    private init(){}
    
    private lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "WeatherApp_MVVM")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    private lazy var context: NSManagedObjectContext = {
        return container.viewContext
    }()
    
    //MARK: - FAVOURITES CORE DATA MANAGEMENT
    func fetchFavsFromCoreData() -> [NSManagedObject]? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavWeather")
        do {
            let result = try context.fetch(fetchRequest)
            print("Objects fetched successfully.")
            return result as? [NSManagedObject]
        } catch {
            print("Failed to fetch data: \(error)")
            return nil
        }
    }
    
    func isWeatherFavourited(id: String) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavWeather")
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            let result = try context.fetch(fetchRequest)
            return !result.isEmpty
        } catch {
            print("Error checking object existence: \(error)")
            return false
        }
    }
    
    func addToFavsCoreData(weather: Weather, completion : @escaping (Bool) -> Void) {
        let favEntity = NSEntityDescription.entity(forEntityName: "FavWeather", in: context)!
        let object = NSManagedObject(entity: favEntity, insertInto: context)
        object.setValue("\(weather.id)", forKey: "id")
        object.setValue(weather.city, forKey: "city")
        object.setValue(weather.country, forKey: "country")
        object.setValue(weather.temperature, forKey: "temperature")
        object.setValue(weather.weatherDescription.rawValue, forKey: "weatherDescription")
        object.setValue(Date(), forKey: "lastFetched")
        do {
            try context.save()
            completion(true)
        } catch {
            completion(false)
        }
    }
    
    func deleteFav(by id: String, completion : @escaping (Bool) -> Void) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavWeather")
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            let result = try context.fetch(fetchRequest)
            if let objectToDelete = result.first as? NSManagedObject {
                context.delete(objectToDelete)
                try context.save()
                completion(true)
            } else {
                completion(false)
            }
        } catch {
            completion(false)
        }
    }
    
    //MARK: - CACHED DATA CORE DATA MANAGEMENT
    func fetchCachedWeathers() -> [NSManagedObject]? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CachedWeather")
        do {
            let result = try context.fetch(fetchRequest)
            print("Cached Data fetched successfully.")
            return result as? [NSManagedObject]
        } catch {
            print("Failed to fetch Cached Data: \(error)")
            return nil
        }
    }
    
    func fetchCachedWeathersWithIds(ids: [String]) -> [NSManagedObject] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CachedWeather")
        fetchRequest.predicate = NSPredicate(format: "id IN %@", ids)
        
        do {
            let result = try context.fetch(fetchRequest)
            return result as? [NSManagedObject] ?? []
        } catch {
            print("Error fetching cached objects with ids: \(error)")
            return []
        }
    }
    
    func cacheOrUpdateFirst10ToCoreData(by array : [Weather], completion : @escaping (Bool) -> Void) {
        let existingWeathers = fetchCachedWeathersWithIds(ids: array.map { "\($0.id)" })
        
        for weather in array {
            if let existingObject = existingWeathers.first(where: { $0.value(forKey: "id") as? String == "\(weather.id)" }) {
                updateCachedWeather(object: existingObject, weather: weather)
            } else {
                addNewCachedWeather(weather: weather)
            }
        }
    }
    
    func addNewCachedWeather(weather : Weather) {
        let entity = NSEntityDescription.entity(forEntityName: "CachedWeather", in: context)!
        let object = NSManagedObject(entity: entity, insertInto: context)
        object.setValue("\(weather.id)", forKey: "id")
        object.setValue(weather.city, forKey: "city")
        object.setValue(weather.country, forKey: "country")
        object.setValue(weather.temperature, forKey: "temperature")
        object.setValue(weather.weatherDescription.rawValue, forKey: "weatherDescription")
        object.setValue(Date(), forKey: "lastFetched")
        
        do {
            try context.save()
            print("Cached Object added successfully.")
        } catch {
            print("Failed to add cached object: \(error)")
        }
    }
    
    func updateCachedWeather(object: NSManagedObject, weather: Weather) {
        object.setValue("\(weather.id)", forKey: "id")
        object.setValue(weather.city, forKey: "city")
        object.setValue(weather.country, forKey: "country")
        object.setValue(weather.temperature, forKey: "temperature")
        object.setValue(weather.weatherDescription.rawValue, forKey: "weatherDescription")
        object.setValue(Date(), forKey: "lastFetched")
        
        do {
            try context.save()
            print("Cached Object updated successfully.")
        } catch {
            print("Failed to update cached object: \(error)")
        }
    }
    
}
