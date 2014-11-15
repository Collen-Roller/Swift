//
//  WeatherData.swift
//  Stormy
//
//  Created by Collen Roller on 11/5/14.
//  Copyright (c) 2014 Collen Roller. All rights reserved.
//

import UIKit
import Foundation

struct WeatherData {
    
    var currentTime : String?
    var temperature: Int
    var humidity: Double
    var percipProb: Double
    var summary: String
    var icon: UIImage?
    
    init(weatherDictionary : NSDictionary){
        
        let currentWeather = weatherDictionary["currently"] as NSDictionary
        
        temperature = currentWeather["temperature"] as Int
        humidity = currentWeather["humidity"] as Double
        percipProb = currentWeather["precipProbability"] as Double
        summary = currentWeather["summary"] as String
        var iconAsString  = currentWeather["icon"] as String
        icon = weatherIconFromString(iconAsString)!
        
        let currentTimeIntValue = currentWeather["time"] as Int
        currentTime = dateStringFromUnixtime(currentTimeIntValue)
        
    }
    
    func dateStringFromUnixtime(unixTime: Int) -> String {
        
        let timeInSeconds = NSTimeInterval(unixTime)
        let weatherDate = NSDate(timeIntervalSince1970: timeInSeconds)
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeStyle = .ShortStyle
        //dateFormatter.dateStyle = .ShortStyle
        
        return dateFormatter.stringFromDate(weatherDate)
    }
    
    func weatherIconFromString(stringIcon: String) -> UIImage? {
        var imageName : String
        
        switch stringIcon {
            
        case "clear-day":
            imageName = "clear-day"
        case "clear-night":
            imageName = "clear-night"
        case "rain":
            imageName = "rain"
        case "snow":
            imageName = "snow"
        case "sleet":
            imageName = "sleet"
        case "wind":
            imageName = "wind"
        case "fog":
            imageName = "fog"
        case "cloudy":
            imageName = "cloudy"
        case "partly-cloudy-day":
            imageName = "partly-cloudy"
        case "partly-cloudy-night":
            imageName = "cloudy-night"
        default:
            imageName = "default"
        }
        
        var iconImage = UIImage(named: imageName)
        return iconImage
    }
    
    
    
    //come up with a way of storing future data
    
}
