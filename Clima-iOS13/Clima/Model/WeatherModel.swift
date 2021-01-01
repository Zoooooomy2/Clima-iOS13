//
//  WeatherModel.swift
//  Clima
//
//  Created by Matt Nutt on 13/12/2020.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    
    let weatherData : WeatherData
    
    var tempString : String {
        return String(format: "%.1f", weatherData.main.temp)
    }
    
    var weatherName : String {
        switch weatherData.weather[0].id {
        case 200...299:
            return "cloud.bolt.rain" //Thunderstorm
        case 300...399:
            return "cloud.drizzle" //Drizzle
        case 500...599:
            return "cloud.rain" //Rain
        case 600...699:
            return "snow" //Snow
        case 700...780:
            return "wind" //Mist, Fog and Sand Storms
        case 781...799:
            return "tornado" //Tornado
        case 800:
            return "sun.min" //Clear Sky
        case 801...899:
            return "smoke" // Cloudy
        default:
            return "sun.max" //Maybe Sunny..
        }
    }
}
