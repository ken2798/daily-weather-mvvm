//
//  ListCityCell.swift
//  WeatherApp
//
//  Created by Bùi Xuân Huy on 7/3/20.
//  Copyright © 2020 huy. All rights reserved.
//

import UIKit

class ListCityCell: UITableViewCell, NibReusable {

    @IBOutlet private weak var nameCityLabel: UILabel!
    @IBOutlet weak var boderView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        boderView.layer.cornerRadius = 23
    }
    
    func configCell(nameCity: String) {
        nameCityLabel.text = nameCity
    }
}
