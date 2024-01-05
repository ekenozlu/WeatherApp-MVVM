//
//  APIManager.swift
//  WeatherApp-MVVM
//
//  Created by Eken Özlü on 5.01.2024.
//

import Foundation

protocol APIDelegate {
    func createRequest(with paramaters : [String : Any]) -> URLRequest?
    func fetchWeathers(of count : Int, completion : @escaping ((Result<[Weather],Error>) -> ()))
    func searchWeather(by text : String, completion : @escaping ((Result<[Weather],Error>) -> ()))
    func getWeatherDetail(by id : String, completion : @escaping ((Result<Weather,Error>) -> ()))
}

final class APIManager : APIDelegate{
    
    private let baseURL = "https://freetestapi.com/api/v1/weathers"
    
    private var itemsPerPage = 10
    
    func createRequest(with paramaters : [String : Any]) -> URLRequest? {
        var urlComponents = URLComponents(string: baseURL)
        var queryItems : [URLQueryItem] = []
        
        for (key,value) in paramaters {
            if let encodedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                let queryItem = URLQueryItem(name: key, value: encodedValue)
                queryItems.append(queryItem)
            }
        }
        
        urlComponents?.queryItems = queryItems
        if let url = urlComponents?.url {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            return request
        } else {
            return nil
        }
    }
    
    func fetchWeathers(of count : Int, completion : @escaping ((Result<[Weather],Error>) -> ())) {
        let currentPage : Int = (count / itemsPerPage) + 1
        print("Current Page: \(currentPage)")
        let limit = itemsPerPage * currentPage
        
        if ConnectionManager.shared.isDeviceConnectedToNetwork() {
            if let request = createRequest(with: ["limit" : limit]) {
                let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
                    if error != nil {
                        completion(.failure(NSError()))
                    } else if let data = data {
                        let weatherArr = try? JSONDecoder().decode([Weather].self, from: data)
                        if currentPage == 1 {
                            CoreDataManager.shared.cacheOrUpdateFirst10ToCoreData(by: weatherArr ?? []) { result in
                                if result {
                                    completion(.success(weatherArr ?? []))
                                }
                            }
                            //SAVE OR UPDATE COREDATA FOR FIRST PAGE ITEMS
                        }
                        completion(.success(weatherArr ?? []))
                    }
                }
                dataTask.resume()
            } else {
                completion(.failure(NSError()))
            }
        }
        else {
            if let objects = CoreDataManager.shared.fetchCachedWeathers() {
                var weatherArr : [Weather] = []
                if objects.isEmpty {
                    completion(.success(weatherArr))
                } else {
                    for object in objects {
                        let weather = Weather(id: object.value(forKey: "id")  as? Int ?? 0,
                                              city: object.value(forKey: "city")  as? String ?? "N/A",
                                              country: object.value(forKey: "country")  as? String ?? "N/A",
                                              latitude: 0.0,
                                              longitude: 0.0,
                                              temperature: object.value(forKey: "temperature")  as? Double ?? 0.0,
                                              weatherDescription: WeatherDescription(rawValue: object.value(forKey: "weatherDescription") as? String ?? "") ?? .sunny,
                                              humidity: 0,
                                              windSpeed: 0.0,
                                              forecast: [])
                        weatherArr.append(weather)
                        completion(.success(weatherArr))
                    }
                }
            } else {
                completion(.failure(NSError()))
            }
        }
        
    }
    
    func searchWeather(by text : String, completion : @escaping ((Result<[Weather],Error>) -> ())) {
        if let request = createRequest(with: ["search" : text]),
           ConnectionManager.shared.isDeviceConnectedToNetwork() {
            let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
                if error != nil {
                    completion(.failure(NSError()))
                } else if let data = data {
                    let weatherArr = try? JSONDecoder().decode([Weather].self, from: data)
                    completion(.success(weatherArr ?? []))
                }
            }
            dataTask.resume()
        } else {
            completion(.failure(NSError()))
        }
    }
    
    func getWeatherDetail(by id : String, completion : @escaping ((Result<Weather,Error>) -> ())) {
        if ConnectionManager.shared.isDeviceConnectedToNetwork(),
           let urlString = URL(string: "\(baseURL)/\(id)"){
            let dataTask = URLSession.shared.dataTask(with: urlString) { data, response, error in
                if error != nil {
                    completion(.failure(NSError()))
                } else if let data = data {
                    let weather = try? JSONDecoder().decode(Weather.self, from: data)
                    completion(.success(weather!))
                }
            }
            dataTask.resume()
        } else {
            completion(.failure(NSError()))
        }
    }
}
