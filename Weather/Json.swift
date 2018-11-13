//
//  File.swift
//  Weather
//
//  Created by Nolan Fuchs on 11/9/18.
//  Copyright © 2018 Nolan Fuchs. All rights reserved.
//

import Foundation
import UIKit

class File: UIViewController {
    
    
    struct Weather: Decodable {
        let latitude: Double
        let longitude: Double
        let description: String
        let temp: Double
        
        
        init(json: [String: Any]) {
            latitude = json["lat"] as? Double ?? -1
            longitude = json["lon"] as? Double ?? -1
            description = json["description"] as? String ?? ""
            temp = json["temp"] as? Double ?? 0.0
            
        }
        
        
    override func viewDidLoad() {
        super.viewDidLoad()
       
        var jsonUrlString = "api.openweathermap.org/data/2.5/weather?lat=&lon=&APPID=5dd568e57c6e8cdd3cf9c0460f2e51fa"
        guard let url = URL(string: jsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            guard let data = data else { return }
            
            
            do {
                let json = try JSONDecoder().decode(Weather.self, from: data)
                
            }
            catch let jsonError {
                print(jsonError)
            }
            }.resume()
        
        
        print("JSON URL: " + jsonUrlString)
    
    }
    
 
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    }
}
