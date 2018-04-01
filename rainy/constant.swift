//
//  constant.swift
//  rainy
//
//  Created by HuangMing on 2017/7/11.
//  Copyright © 2017年 Fruit. All rights reserved.
//

import UIKit

typealias DownloadComplete = (Bool) -> ()

class constant {
    
    var _weatherURL: String!
    var _latitude: Double!
    var _longitude: Double!
    var _weather10URL: String!
    
    
    var latitude: Double {
        get {
            return _latitude
        }
        set {
            _latitude = newValue
        }
    }
    var longitude: Double {
        get {
            return _longitude
        }
        set {
            _longitude = newValue
        }
    }
    
    var WHEATHER_URL: String {
        get {
            _weatherURL = "http://api.openweathermap.org/data/2.5/weather?lat=\(self._latitude!)&lon=\(self._longitude!)&appid=e70551c051f907fdc4f970740e383a29"
            return _weatherURL
        }
    }
    var weather10URL: String {
        get {
            _weather10URL = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=\(self._latitude!)&lon=\(self._longitude!)&cnt=10&appid=e70551c051f907fdc4f970740e383a29"
            return _weather10URL
        }
    }
    init(latitude: Double, longitude: Double) {
        self._latitude = latitude
        self._longitude = longitude
    }
}
