//
//  HourlyWeatherCell.swift
//  WeatherApp
//
//  Created by Bùi Xuân Huy on 7/7/20.
//  Copyright © 2020 huy. All rights reserved.
//

import UIKit

final class HourlyWeatherCell: UICollectionViewCell, NibReusable {

 
    @IBOutlet weak var boderView: UIView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        boderView.layer.cornerRadius = 23
    }
    
    func setContentForCell(data: HourWeatherData) {
        tempLabel.text = data.temp
        hourLabel.text = data.hour + "h"
        iconImageView.sd_setImage(with: URL(string: data.icon))
    }
}
