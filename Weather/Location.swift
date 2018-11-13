//
//  Location.swift
//  Weather
//
//  Created by Nolan Fuchs on 11/9/18.
//  Copyright © 2018 Nolan Fuchs. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation


struct WeatherData: Decodable {
    let coord: Coordinates
    let weather: [Weather]
    let id: Int
    let name: String
    let cod: Int
    let main: Main
    
}

struct Coordinates: Decodable {
    let lon: Double
    let lat: Double
}

struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Main: Decodable {
    let temp: Double
    let pressure: Int
    let humidity: Int
    let temp_min: Double
    let temp_max: Double
    
}

class Location: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var degreeLabel: UILabel!
    @IBOutlet weak var overcastLabel: UILabel!
    @IBOutlet weak var coordinateLabel: UILabel!
    
    var overcastData = ""
        
        
    
    
    let locationManager:CLLocationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
      
       
      
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for currentLocation in locations {
            print("\(index): \(locations)")
            
            coordinateLabel.text = "\(currentLocation.coordinate.latitude), \(currentLocation.coordinate.longitude)"
           
            var jsonUrlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(currentLocation.coordinate.latitude)&lon=\(currentLocation.coordinate.longitude)&APPID=5dd568e57c6e8cdd3cf9c0460f2e51fa"
            guard let url = URL(string: jsonUrlString) else { return }
            
            URLSession.shared.dataTask(with: url) { (data, response, err) in
                
                guard let data = data else { return }
                
                
                do {
                    let weather = try JSONDecoder().decode(WeatherData.self, from: data)
                    DispatchQueue.main.async {
                    self.overcastLabel.text = weather.weather[0].description
                    self.locationLabel.text = weather.name
                    let Celcius = weather.main.temp-273.15
                    let Farnheit = (Celcius*(9.0/5.0) + 32.0)
                    self.degreeLabel.text = "\(Double(round(1000*Farnheit)/1000)) F / \(Double(round(1000*Celcius)/1000)) C"
                    }
                    print("\(weather.coord.lat) & \(weather.coord.lon). Code: \(weather.cod). City Name: \(weather.name). TESTING: \(weather.main.temp)")
                }
                catch let jsonError {
                    print(jsonError)
                }
                }.resume()
            
          
            
            print("JSON URL: " + jsonUrlString)
            
           
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    
    
    
    
    
}

