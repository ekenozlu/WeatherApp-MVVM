//
//  CoreDataManager.swift
//  WeatherApp-MVVM
//
//  Created by Eken Özlü on 5.01.2024.
//

import UIKit
import CoreData

final class CoreDataManager {
    //MARK: - Singleton Object
    public static let shared = CoreDataManager()
    
    //MARK: - Initializer
    private init(){}
    
    //MARK: - CoreData container variable
    private lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "WeatherApp_MVVM")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    //MARK: - Context for CoreData functions
    private lazy var context: NSManagedObjectContext = {
        return container.viewContext
    }()
    
    //MARK: - FAVOURITES CORE DATA MANAGEMENT
    ///This function fetchs favourited objects(Weather) from Core Data
    ///
    ///> Returns:
    ///>Function returns an optional object array, If an error occurs during the fetching it returns nil.
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
    
    //MARK: - FAVOURITES CORE DATA MANAGEMENT
    ///This function checks the specific object is favourited in CoreData or not.
    ///
    ///> Parameters:
    ///> "id: String" should be the id of the desired object
    ///
    ///> Returns:
    ///> A bool value according to the result. If it is favourited it returns true.
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
    
    ///This function adds specific object to favourited CoreData
    ///
    ///> Parameters:
    ///> "weather: Weather" should be the object itself
    ///
    ///> Returns:
    ///> A completion that returns a bool value. If an error occurs during the process it returns false, If it succeed it returns true
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
    ///This function deletes specific object from favourited CoreData
    ///
    ///> Parameters:
    ///> "by id: String" should be the object's id
    ///
    ///> Returns:
    ///> A completion that returns a bool value. If an error occurs during the process it returns false, If it succeed it returns true
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
    ///This function fetchs the previously cached data from CoreData
    ///
    ///> Returns:
    ///> Function returns an optional object array, If an error occurs during the fetching it returns nil.
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
    
    ///This function cache or update the given object array to CoreData
    ///
    ///> Parameters:
    ///> "by array : [Weather]" should be the array of object
    ///
    ///> Returns:
    ///> A completion for sync functions.
    func cacheOrUpdateFirst10ToCoreData(by array : [Weather], completion : @escaping () -> Void) {
        let existingWeathers = fetchCachedWeathersWithIds(ids: array.map { "\($0.id)" })
        
        for weather in array {
            if let existingObject = existingWeathers.first(where: { $0.value(forKey: "id") as? String == "\(weather.id)" }) {
                updateCachedWeather(object: existingObject, weather: weather)
            } else {
                addNewCachedWeather(weather: weather)
            }
        }
        completion()
    }
    
    ///This function fetchs the specific objects according to given ids
    ///
    ///> Parameters:
    ///> "ids: [String]" should be the array of id's
    ///
    ///> Returns:
    ///> An object array
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
    
    ///This function adds specific object to cached CoreData
    ///
    ///> Parameters:
    ///> "weather: Weather" should be the object itself
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
    
    ///This function updates the specific object in CoreData
    ///
    ///> Parameters:
    ///> "object: NSManagedObject" should be the object itself from CoreData
    ///> "weather: Weather" should be the object with new data
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
