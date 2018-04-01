//
//  ViewController.swift
//  rainy
//
//  Created by HuangMing on 2017/7/10.
//  Copyright © 2017年 Fruit. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    @IBOutlet weak var currentDateLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentCity: UILabel!
    @IBOutlet weak var currentTemperature: UILabel!
    
    @IBOutlet weak var currentWheather: UILabel!
    @IBOutlet weak var weatherTableView: UITableView!
    var currentWeather: CurrentWeather!
    var forecast: Forecast!
    var forecasts = [Forecast]()
    var locationManager = CLLocationManager()
    var currentLocation = CLLocation()
    static var constantURL: constant!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherTableView.delegate = self
        weatherTableView.dataSource = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        processingLocation()
        
    }
 
    
    
    func processingLocation() {
        if allowAuthorization() {
            updateLocation()
        }
    }
    
    func allowAuthorization() -> Bool {
        let auth = CLLocationManager.authorizationStatus()
        guard auth == .authorizedWhenInUse else {
            showLocationAlert()
            return false
        }
        return true
    }
    
    func updateLocation() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startMonitoringSignificantLocationChanges()
        locationManager.startUpdatingLocation()
        currentLocation = locationManager.location!
        Location.sharedInstance.latitude = currentLocation.coordinate.latitude
        Location.sharedInstance.longitude = currentLocation.coordinate.longitude
        
        print(Location.sharedInstance.latitude, Location.sharedInstance.longitude)
        let latitude = Location.sharedInstance.latitude
        let longitude = Location.sharedInstance.longitude
        ViewController.constantURL = constant.init(latitude: latitude!, longitude: longitude!)
        
        currentWeather = CurrentWeather()
        
        print(currentLocation.coordinate.latitude, currentLocation.coordinate.longitude)
        
        currentWeather.downloadWeatherDetails { complete in
            if complete {
                self.downloadForecastData { complete in
                    self.updateCurrentUI()
                    
                }
            }
            
        }
    }
    func showLocationAlert() {
        let alert = UIAlertController(title: "Authorization", message: "Please enable Location services for this app in Setting", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .default) { (action) in
        }
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }
    
    func downloadForecastData(completed: @escaping DownloadComplete) {
        let forecastURL = URL(string: ViewController.constantURL.weather10URL)!
        print(forecastURL)
        Alamofire.request(forecastURL).responseJSON { (response) in
            if let responseValue = response.value as? Dictionary<String, AnyObject> {
                
                if let lists = responseValue["list"] as? [Dictionary<String, AnyObject>] {
                    self.forecasts.removeAll()
                    for obj in lists {
                        let get = Forecast(weatherDictionary: obj)
                        self.forecasts.append(get)
                        
                    }
                    DispatchQueue.main.async {
                        self.weatherTableView.reloadData()
                        completed(true)
                    }
                    
                }
            }
            
        }
        
    }
    
    func updateCurrentUI() {
        currentDateLabel.text = currentWeather.date
        currentCity.text = currentWeather.cityName
        currentTemperature.text = String(currentWeather.currentTemp) + "°c"
        currentWeatherImage.image = UIImage(named: currentWeather.weatherType)
        currentWheather.text = currentWeather.weatherType
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? WeatherCell {
            let forecastIndexPath = forecasts[indexPath.row]
            cell.WeekOfDataConfiqueCell(forecast: forecastIndexPath)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    @IBAction func reloadBTN(_ sender: UIButton) {
        
        if allowAuthorization() {
            updateLocation()

            self.weatherTableView.reloadData()
        }
    }
}

