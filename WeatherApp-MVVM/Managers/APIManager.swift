//
//  APIManager.swift
//  WeatherApp-MVVM
//
//  Created by Eken Özlü on 5.01.2024.
//

import Foundation

protocol APIManagerProtocol : AnyObject {
    func createRequest(with paramaters : [String : Any]) -> URLRequest?
    func fetchWeathers(of count : Int, completion : @escaping (_ weatherArr: [Weather]?, _ networkStatus: Bool?, _ error: ErrorType?) -> Void)
    func searchWeather(by text : String, completion : @escaping (_ weatherArr: [Weather]?, _ networkStatus: Bool?, _ errorDescription: ErrorType?) -> Void)
    func getWeatherDetail(by id : String, completion : @escaping (_ weather: Weather?, _ networkStatus: Bool?, _ errorDescription: ErrorType?) -> ())
}

final class APIManager : APIManagerProtocol{
    
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
    
    func fetchWeathers(of count : Int, completion : @escaping (_ weatherArr: [Weather]?, _ networkStatus: Bool?, _ error: ErrorType?) -> Void) {
        let currentPage : Int = (count / itemsPerPage) + 1
        let limit = itemsPerPage * currentPage
        
        if ConnectionManager.shared.isDeviceConnectedToNetwork() {
            if let request = createRequest(with: ["limit" : limit]) {
                let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
                    if error != nil {
                        completion(nil,true,.unableToFetchFromNetwork)
                    } else if let data = data {
                        let weatherArr = try? JSONDecoder().decode([Weather].self, from: data)
                        if currentPage == 1 {
                            CoreDataManager.shared.cacheOrUpdateFirst10ToCoreData(by: weatherArr ?? []) { result in
                                if result {
                                    completion(weatherArr!,true,nil)
                                }
                            }
                        }
                        completion(weatherArr!,true,nil)
                    }
                }
                dataTask.resume()
            } else {
                completion(nil,true,.unableToFetchFromNetwork)
            }
        }
        else {
            if let objects = CoreDataManager.shared.fetchCachedWeathers() {
                var weatherArr : [Weather] = []
                if objects.isEmpty {
                    completion(nil,false,.emptyCoreData)
                } else {
                    for object in objects {
                        let weather = Weather(id: Int(object.value(forKey: "id") as? String ?? "-1")!,
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
                    }
                    completion(weatherArr,false,nil)
                }
            } else {
                completion(nil,false,.unableToFetchFromCoreData)
            }
        }
    }
    
    func searchWeather(by text : String, completion : @escaping (_ weatherArr: [Weather]?, _ networkStatus: Bool?, _ error: ErrorType?) -> Void) {
        if let request = createRequest(with: ["search" : text]),
           ConnectionManager.shared.isDeviceConnectedToNetwork() {
            let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
                if error != nil {
                    completion(nil,true,.unableToFetchFromNetwork)
                } else if let data = data {
                    let weatherArr = try? JSONDecoder().decode([Weather].self, from: data)
                    completion(weatherArr!,true,nil)
                }
            }
            dataTask.resume()
        } else {
            completion(nil,false,.noConnection)
        }
    }
    
    func getWeatherDetail(by id : String, completion : @escaping (_ weather: Weather?, _ networkStatus: Bool?, _ error: ErrorType?) -> ()) {
        if ConnectionManager.shared.isDeviceConnectedToNetwork(),
           let urlString = URL(string: "\(baseURL)/\(id)"){
            let dataTask = URLSession.shared.dataTask(with: urlString) { data, response, error in
                if error != nil {
                    completion(nil,true,.unableToFetchFromNetwork)
                } else if let data = data {
                    let weather = try? JSONDecoder().decode(Weather.self, from: data)
                    completion(weather!,true,nil)
                }
            }
            dataTask.resume()
        } else {
            completion(nil,false,.noConnection)
        }
    }
}
