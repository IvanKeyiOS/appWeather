//
//  WeatherViewModel.swift
//  appWeather
//
//  Created by Иван Курганский on 01/10/2023.
//

import Foundation

class WeatherViewModel {
    
    static let currentQuery = "current.json"
    static let baseURL = "https://api.weatherapi.com/v1/"
    static let apiKey = "ba125a4741684032b5b31544230208"
    
    static func fetchWeatherDetailsWith(latitude: Double, longitude: Double, completion: @escaping (WeatherModel?, Bool) -> ()) {
        
        guard var urlComponent = URLComponents(string: baseURL + currentQuery) else { return }
        
        urlComponent.queryItems = [
            URLQueryItem(name: "key", value: apiKey),
            URLQueryItem(name: "q", value: "\(latitude),\(longitude)")
        ]
        guard let url = urlComponent.url?.absoluteURL else { return }
        let task = URLSession.shared.dataTask(with:  url) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let weatherModel = try JSONDecoder().decode(WeatherModel.self, from: data)
                completion(weatherModel, true)
                print(weatherModel)
            } catch {
                completion(nil, false)
            }
        }
        task.resume()
    }
    
    static func fetchWeatherBasedOn(cityName: String, completion: @escaping (WeatherModel?, Bool) -> ()) {
        guard var urlComponent = URLComponents(string: baseURL + self.currentQuery) else { return }
        urlComponent.queryItems = [
            URLQueryItem(name: "key", value: self.apiKey),
            URLQueryItem(name: "q", value: "\(cityName)")
        ]
        guard let url = urlComponent.url?.absoluteURL else { return }
        let task = URLSession.shared.dataTask(with:  url) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let weatherModel = try JSONDecoder().decode(WeatherModel.self, from: data)
                completion(weatherModel, true)
                print(weatherModel)
            } catch {
                completion(nil, false)
            }
        }
        task.resume()
    }
}
