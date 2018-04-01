//
//  Location.swift
//  rainy
//
//  Created by HuangMing on 2017/7/12.
//  Copyright © 2017年 Fruit. All rights reserved.
//

import CoreLocation
class Location {
    static var sharedInstance = Location()
    private init() {}
    
    var latitude: Double!
    var longitude: Double!
}
