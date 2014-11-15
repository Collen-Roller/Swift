//
//  ViewController.swift
//  Stormy
//
//  Created by Collen Roller on 11/3/14.
//  Copyright (c) 2014 Collen Roller. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var percentRainLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var refreshActivityIndicator: UIActivityIndicatorView!
    
    
    let apiKey : String = "5b16ada0aa5ca7212fc84f9c2dfe989d"

    var myLocation : String = "44.669957,-74.982028"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshActivityIndicator.hidden = true
        
        getCurrentWeatherData()
    }
    
    func getCurrentWeatherData() -> Void {
        // Do any additional setup after loading the view, typically from a nib.
        self.myLocation = "44.669957,-74.982028"
        let baseURL = NSURL(string: "https://api.forecast.io/forecast/\(apiKey)/")
        let locationURL = NSURL(string: "\(myLocation)", relativeToURL: baseURL)
        //println(locationURL)
        //let weatherData = NSData(contentsOfURL: locationURL!, options: nil, error: nil)
        //println(weatherData)
        
        let sharedSession = NSURLSession.sharedSession()
        let downloadTask: NSURLSessionDownloadTask =
        sharedSession.downloadTaskWithURL(locationURL!,
            completionHandler: { (location: NSURL!, response:
                NSURLResponse!, error: NSError!) -> Void in
                println(error)
                
                if(error == nil){
                    let dataObject = NSData(contentsOfURL: location)
                    let weatherDictionary: NSDictionary =
                    NSJSONSerialization.JSONObjectWithData(
                        dataObject!, options: nil, error: nil)
                        as NSDictionary
                    //println(weatherDictionary)
                    
                    let currentWeather = WeatherData(weatherDictionary: weatherDictionary)
                    println(currentWeather.currentTime!)
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.tempLabel.text = "\(currentWeather.temperature)"
                        self.percentRainLabel.text = "\(currentWeather.percipProb)"
                        self.summaryLabel.text = "\(currentWeather.summary)"
                        self.humidityLabel.text = "\(currentWeather.humidity)"
                        self.currentTimeLabel.text = "At \(currentWeather.currentTime!) it is"
                        self.iconView.image = currentWeather.icon!
                        
                        self.refreshActivityIndicator.stopAnimating()
                        self.refreshActivityIndicator.hidden = true
                        self.refreshButton.hidden = false
                    })
                }
                else {
                    let networkIssueController = UIAlertController(title: "Error", message:
                        "Unable to load data. Connectivity error", preferredStyle: .Alert)
                    
                    let okButton = UIAlertAction(title: "OK", style: .Default, handler: nil)
                    networkIssueController.addAction(okButton)
                    
                    let cancelButton = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
                    networkIssueController.addAction(cancelButton)
                    
                    self.presentViewController(networkIssueController, animated: true, completion: nil)
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.refreshActivityIndicator.stopAnimating()
                        self.refreshActivityIndicator.hidden = true
                        self.refreshButton.hidden = false
                    })
                }
        })
        downloadTask.resume()
    }

    @IBAction func refresh() {
        
        getCurrentWeatherData()
        
        refreshButton.hidden = true
        refreshActivityIndicator.hidden = false
        refreshActivityIndicator.startAnimating()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setNewLocation(location : String){
        self.myLocation = location
    }
}

