//
//  WeatherViewModel.swift
//  appWeather
//
//  Created by Иван Курганский on 01/10/2023.
//

import Foundation

class WeatherViewModel {
    
    static func fetchWeatherDetailsWith(latitude: Double, longitude: Double, completion: @escaping (WeatherModel?, Bool) -> ()) {
        WeatherService.fetchWeatherDetailsWith(latitude: latitude, longitude: longitude) { weatherModel, status in
            completion(weatherModel, status)
        }
    }
    
    static func fetchWeatherBasedOn(cityName: String, completion: @escaping (WeatherModel?, Bool) -> ()) {
        WeatherService.fetchWeatherBasedOn(cityName: cityName) { weatherModel, status in
            completion(weatherModel, status)
        }
    }
}


