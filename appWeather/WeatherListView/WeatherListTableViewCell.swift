//
//  WeatherListTableViewCell.swift
//  appWeather
//
//  Created by Иван Курганский on 01/10/2023.
//

import UIKit

class WeatherListTableViewCell: UITableViewCell {
    @IBOutlet weak var labelTemperature: UILabel!
    @IBOutlet weak var labelCondition: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    
    @IBOutlet weak var labelCityName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
