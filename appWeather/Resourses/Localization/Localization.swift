//
//  Localization.swift
//  appWeather
//
//  Created by Иван Курганский on 10/10/2023.
//

import UIKit

enum Localization: String {
    case currentLocation = "current_location"
    case cityIsNotFound = "city_is_not_found"
    case cities = "cities"
    case celsius = "celsius"
    case fahrenheit = "fahrenheit"
    
    var text: String {
        return NSLocalizedString(rawValue, comment: "")
    }
}
