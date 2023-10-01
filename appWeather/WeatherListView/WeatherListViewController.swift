//
//  WeatherListViewController.swift
//  appWeather
//
//  Created by Иван Курганский on 01/10/2023.
//

import UIKit

class WeatherListViewController: UIViewController {


    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "WeatherListTableViewCell", bundle: nil), forCellReuseIdentifier: "WeatherListTableViewCell")
    }
}

extension WeatherListViewController: UITableViewDelegate {
    
}

extension WeatherListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LocalDataManager.weatherCollection.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherListTableViewCell", for: indexPath) as? WeatherListTableViewCell else {
            return UITableViewCell()
        }
        cell.labelCityName.text = LocalDataManager.weatherCollection[indexPath.row].cityName
        cell.labelTemperature.text = LocalDataManager.weatherCollection[indexPath.row].temperature
        cell.labelCondition.text = LocalDataManager.weatherCollection[indexPath.row].weatherCondition
        cell.weatherImage.image = ImageManager.getWeatherImagesBasedOn(codeForWeather: LocalDataManager.weatherCollection[indexPath.row].imageCode)
        return cell
    }
    
    
}
