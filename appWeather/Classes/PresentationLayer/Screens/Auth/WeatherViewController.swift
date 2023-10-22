//
//  WeatherViewController.swift
//  appWeather
//
//  Created by Иван Курганский on 01/10/2023.
//

import UIKit
import MapKit

class WeatherViewController: UIViewController {
    
    @IBOutlet private weak var labelWeatherCondition: UILabel!
    @IBOutlet private weak var labelCityName: UILabel!
    @IBOutlet private weak var buttonCities: UIButton!
    @IBOutlet private weak var labelTemperature: UILabel!
    @IBOutlet private weak var segmentControl: UISegmentedControl!
    @IBOutlet private weak var weatherImageView: UIImageView!
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var buttonSearch: UIButton!
    @IBOutlet private weak var buttonLocation: UIButton!
    
    var weatherTracker: WeatherModel?
    var searchedCity: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newSegmentTitleZero = Localization.celsius.text
        segmentControl.setTitle(newSegmentTitleZero, forSegmentAt: 0)
        let newSegmentTitleOne = Localization.fahrenheit.text
        segmentControl.setTitle(newSegmentTitleOne, forSegmentAt: 1)
        
        let newButtonTitle = Localization.cities.text
        buttonCities.setTitle(newButtonTitle, for: .normal)
        
        self.initialSetup()
    }
    
    fileprivate func initialSetup() {
        self.searchBar.delegate = self
        self.labelTemperature.text = ""
        self.labelCityName.text = ""
        self.labelWeatherCondition.text = ""
        self.segmentControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
    }
    
    fileprivate func makeInitialWeatherRequest() {
        LocationManager.shared.getLocation { [weak self] location in
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                let latitude = location.coordinate.latitude
                let longitude = location.coordinate.longitude
                
                WeatherViewModel.fetchWeatherDetailsWith(latitude: latitude, longitude: longitude) { weatherModel, status in
                    switch status {
                    case true:
                        self.weatherTracker = weatherModel
                        self.computeWeatherDetailsBeforeRendering(weatherModel: weatherModel, ifCurrentLocation: true)
                    case false:
                        break
                    }
                }
            }
        }
    }
    
    fileprivate func computeWeatherDetailsBeforeRendering(weatherModel: WeatherModel?, ifCurrentLocation: Bool) {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.weatherTracker = weatherModel
            let locationName = ifCurrentLocation == true ? Localization.currentLocation.text : "\(weatherModel?.location.name ?? "")"
            strongSelf.labelCityName.text = locationName
            strongSelf.labelWeatherCondition.text = "\(weatherModel?.current.condition?.text ?? "")"
            strongSelf.labelTemperature.text = "\(weatherModel?.current.tempC ?? 0.0) °C"
            strongSelf.weatherImageView.image = ImageManager.getWeatherImagesBasedOn(codeForWeather: weatherModel?.current.condition?.code ?? 0)
            strongSelf.segmentControl.selectedSegmentIndex = 0
            
            LocalDataManager.weatherCollection.append(WeatherLocalModel(cityName: locationName, weatherCondition: weatherModel?.current.condition?.text ?? "", temperature: String(weatherModel?.current.tempC ?? 0.0), imageCode: weatherModel?.current.condition?.code ?? 0))
        }
    }
    
    fileprivate func makeRequest() {
        self.view.endEditing(true)
        WeatherViewModel.fetchWeatherBasedOn(cityName: self.searchedCity) { [weak self] weatherModel, status in
            guard let self = self else { return }
            switch status {
            case true:
                self.computeWeatherDetailsBeforeRendering(weatherModel: weatherModel, ifCurrentLocation: false)
            case false:
                DispatchQueue.main.async {
                    self.labelCityName.text = Localization.cityIsNotFound.text
                    self.labelWeatherCondition.text = ""
                    self.labelTemperature.text = ""
                    self.weatherImageView.image = UIImage(systemName: "exclamationmark.triangle.fill")
                }
               
            }
        }
    }

    
    @IBAction private func didSelectSegmentControl(_ sender: UISegmentedControl) {
        guard let weather = weatherTracker else { return }
        switch segmentControl.selectedSegmentIndex {
        case 0:
            self.labelTemperature.text = "\(weather.current.tempC ?? 0.0) °C"
        case 1:
            self.labelTemperature.text = "\(weather.current.tempF ?? 0.0) °F"
        default:
            break
        }
    }
    
    @IBAction private func didTapLocation(_ sender: Any) {
        self.makeInitialWeatherRequest()
    }
    
    @IBAction private func didTapSearch(_ sender: Any) {
        self.makeRequest()
    }
    
    @IBAction private func didTapCities(_ sender: Any) {}
}

extension WeatherViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        labelTemperature.text = ""
        labelCityName.text = ""
        labelWeatherCondition.text = ""
        weatherImageView.image = UIImage(systemName: "sun.min.fill")
        
        if !searchText.isEmpty {
            self.searchedCity = searchText
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text, !searchText.isEmpty {
            self.searchedCity = searchText
            self.makeRequest()
        }
    }
}


