//
//  WeatherCell.swift
//  rainy
//
//  Created by HuangMing on 2017/7/12.
//  Copyright © 2017年 Fruit. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellWeek: UILabel!
    @IBOutlet weak var cellWeatherType: UILabel!

    @IBOutlet weak var cellMinTemp: UILabel!
    @IBOutlet weak var cellMaxTemp: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    func WeekOfDataConfiqueCell(forecast: Forecast) {
        cellImage.image = UIImage(named: forecast.weatherType)
        cellWeek.text = forecast.date
        cellWeatherType.text = forecast.weatherType
        cellMaxTemp.text = String(forecast.maxTemp) + "°c"
        cellMinTemp.text = String(forecast.lowTemp) + "°c"
        cellImage.layer.cornerRadius = 10
    }
    

}
