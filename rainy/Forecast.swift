//
//  Forecast.swift
//  rainy
//
//  Created by HuangMing on 2017/7/11.
//  Copyright © 2017年 Fruit. All rights reserved.
//

import UIKit

class Forecast {
    
    var _date: String!
    var _weatherType: String!
    var _maxTemp: Double!
    var _lowTemp: Double!
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        return _date
    }
    var weatherType: String {
        get {
            return _weatherType
        }
        set {
            if _weatherType == nil {
                _weatherType = ""
            }
            _weatherType = newValue
        }
    }
    var maxTemp: Double {
        if _maxTemp == nil {
            _maxTemp = 0.0
        }
        return _maxTemp
    }
    var lowTemp: Double {
        if _lowTemp == nil {
            _lowTemp = 0.0
        }
        return _lowTemp
    }
    init(weatherDictionary: Dictionary<String, AnyObject>) {
        if let temp = weatherDictionary["temp"] as? Dictionary<String, AnyObject> {
            if let min = temp["min"] as? Double {
                let tempCelsius = min - 273.15
                
                let tempCelsiusRound = Double(round(10 * tempCelsius) / 10)
                _lowTemp = tempCelsiusRound
            }
            if let max = temp["max"] as? Double {
                let tempCelsius = max - 273.15
                
                let tempCelsiusRound = Double(round(10 * tempCelsius) / 10)
                _maxTemp = tempCelsiusRound
            }
        }
        if let weather = weatherDictionary["weather"] as? [Dictionary<String, AnyObject>] {
            if let main = weather[0]["main"] as? String {
                _weatherType = main
            }
        }
        if let date = weatherDictionary["dt"] as? Double {
            let unixConvertedDate = Date(timeIntervalSince1970: date)
            _date = unixConvertedDate.dayOfWeek()
        }
        
    }
}

extension Date {
    func dayOfWeek() -> String{
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .none
        formatter.dateFormat = "EEEE"
        return formatter.string(from: self)
    }
}
