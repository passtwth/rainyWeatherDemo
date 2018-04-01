//
//  CurrentWeather.swift
//
//
//  Created by HuangMing on 2017/7/11.
//
//

import UIKit
import Alamofire
class CurrentWeather {
    
    var _cityName: String!
    var _date: String!
    var _weatherType: String!
    var _currentTemp: Double!
    
    var cityName: String {
        get {
            if _cityName == nil {
                _cityName = ""
            }
            return _cityName
        }
        set {
            _cityName = newValue
        }
    }
    var date: String {
        if _date == nil {
            _date = ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today, \(currentDate)"
        
        return _date
    }
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        
        return _weatherType
    }
    var currentTemp: Double {
        get {
            if _currentTemp == nil {
                _currentTemp = 0.0
            }
            return _currentTemp
        }
        set {
            _currentTemp = newValue
            
        }
    }
    
    func downloadWeatherDetails(completed: @escaping DownloadComplete) {
        let currentURL = URL(string: ViewController.constantURL.WHEATHER_URL)!
        
        Alamofire.request(currentURL).responseJSON { response in
            
            
            if let dictionary = response.value as? Dictionary<String, AnyObject> {
                print(dictionary)
                
                if let name = dictionary["name"] as? String {
                    self._cityName = name.capitalized
                   // print(self._cityName)
                   // print(self.cityName)
                }
                if let weather = dictionary["weather"] as? [Dictionary<String, AnyObject>] {
                    
                    if let main = weather[0]["main"] as? String{
                        self._weatherType = main.capitalized
                       // print(self._weatherType)
                    }
                }
                if let main = dictionary["main"] as? Dictionary<String, AnyObject> {
                    if let tempKelvin = main["temp"] as? Double {
                        
                        //let tempFarenheit = (tempKelvin * 9 / 5) - 459.67
                        //let tempFarenheitRound = Double(round(100 * tempFarenheit) / 100)
                       // print(tempFarenheitRound)
                        let tempCelsius = tempKelvin - 273.15
                        
                        let tempCelsiusRound = Double(round(10 * tempCelsius) / 10)
                       // print(tempCelsiusRound)
                        self._currentTemp = tempCelsiusRound
                    }
                }
                
            }
            completed(true)
        }
        
    }
    
}
