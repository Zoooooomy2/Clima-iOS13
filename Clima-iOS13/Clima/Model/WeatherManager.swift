//
//  WeatherManager.swift
//  Clima
//
//  Created by Matt Nutt on 11/12/2020.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, _ weather: WeatherModel)
    func didFailWithError(_ error: Error)
}

struct WeatherManager {
    
    let key : String = MyKeys.weatherAPI
    
    var delegate : WeatherManagerDelegate?
    
    var weatherURL: String {"https://api.openweathermap.org/data/2.5/weather?appid=\(key)&units=metric&"}
    var weatherTown = "q="
    var weatherState = ","
    var weatherZip = ","
    var weatherCountry = ","
    
    func fetchWeather (cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func fetchWeather (location: CLLocation) {
        let lon = location.coordinate.longitude
        let lat = location.coordinate.latitude
        let urlString = "\(weatherURL)&lon=\(lon)&lat=\(lat)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    delegate?.didFailWithError(error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(weatherData: safeData) {
                        self.delegate?.didUpdateWeather(self, weather)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let weather = WeatherModel(weatherData: decodedData)
            return weather
        }catch{
            delegate?.didFailWithError(error)
            return nil
        }
    }
    
}
