//
//  WeatherServes.swift
//  appWeather
//
//  Created by Иван Курганский on 07/10/2023.
//

import Foundation

class WeatherService {
    
    static private let currentQuery = "current.json"
    static private let baseURL = "https://api.weatherapi.com/v1/"
    static private let apiKey = "ba125a4741684032b5b31544230208"
    
    static func fetchWeatherDetailsWith(latitude: Double, longitude: Double, completion: @escaping (WeatherModel?, Bool) -> ()) {
        guard var urlComponent = URLComponents(string: baseURL + currentQuery) else { return }
        
        urlComponent.queryItems = [
            URLQueryItem(name: "key", value: apiKey),
            URLQueryItem(name: "q", value: "\(latitude),\(longitude)")
        ]
        
        guard let url = urlComponent.url?.absoluteURL else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(nil, false)
                return
            }
            
            do {
                let weatherModel = try JSONDecoder().decode(WeatherModel.self, from: data)
                completion(weatherModel, true)
            } catch {
                completion(nil, false)
            }
        }
        task.resume()
    }
    
    static func fetchWeatherBasedOn(cityName: String, completion: @escaping (WeatherModel?, Bool) -> ()) {
        guard var urlComponent = URLComponents(string: baseURL + currentQuery) else { return }
        urlComponent.queryItems = [
            URLQueryItem(name: "key", value: apiKey),
            URLQueryItem(name: "q", value: "\(cityName)")
        ]
        
        guard let url = urlComponent.url?.absoluteURL else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(nil, false)
                return
            }
            
            do {
                let weatherModel = try JSONDecoder().decode(WeatherModel.self, from: data)
                completion(weatherModel, true)
            } catch {
                completion(nil, false)
            }
        }
        
        task.resume()
    }
}
