//
//  WeatherListViewController.swift
//  appWeather
//
//  Created by Иван Курганский on 01/10/2023.
//

import UIKit

class WeatherListViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!

    @IBOutlet weak var citiesLabel: UILabel!
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func viewDidLoad() {
        
        let newLabelText = Localization.cities.text
        citiesLabel.text = newLabelText
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        let cellNib = UINib(nibName: "WeatherListTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "WeatherListTableViewCell")
    }
}

extension WeatherListViewController: UITableViewDelegate {
}

extension WeatherListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LocalDataManager.weatherCollection.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherListTableViewCell", for: indexPath) as? WeatherListTableViewCell {
            cell.labelCityName.text = LocalDataManager.weatherCollection[indexPath.row].cityName
            cell.labelTemperature.text = "\(LocalDataManager.weatherCollection[indexPath.row].temperature + "°C")"
            cell.labelCondition.text = LocalDataManager.weatherCollection[indexPath.row].weatherCondition
            cell.weatherImage.image = ImageManager.getWeatherImagesBasedOn(codeForWeather: LocalDataManager.weatherCollection[indexPath.row].imageCode)
            return cell
        }
        return UITableViewCell()
    }
}
