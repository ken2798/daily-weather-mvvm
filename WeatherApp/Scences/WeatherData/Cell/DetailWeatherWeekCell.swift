//
//  DetailWeatherWeekCell.swift
//  WeatherApp
//
//  Created by Bùi Xuân Huy on 7/7/20.
//  Copyright © 2020 huy. All rights reserved.
//

final class DetailWeatherWeekCell: UITableViewCell, NibReusable {

    @IBOutlet private weak var degreeLabel: UILabel!
    @IBOutlet private weak var iconWeather: UIImageView!
    @IBOutlet private weak var dayOfWeekLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func setContentForCell(data: DailyWeatherData) {
        degreeLabel.text = data.temp
        dayOfWeekLabel.text = data.day
        iconWeather.sd_setImage(with: URL(string: data.icon))
    }
}
