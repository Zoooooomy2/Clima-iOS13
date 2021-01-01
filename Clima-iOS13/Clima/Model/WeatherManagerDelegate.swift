//
//  WeatherManagerDelegate.swift
//  Clima
//
//  Created by Matt Nutt on 13/12/2020.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(weather: WeatherModel)
}
