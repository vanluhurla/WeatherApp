//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Vanessa Hurla on 22/05/2024.
//

// This class contains two asynchronous functions that fetch a current weather data and a five-day weather forecast using the OpenWeatherMap API.

import Foundation
import CoreLocation

class WeatherManager {
    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> ResponseBody {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=133a99cae05060e51c3f76f2a3bd53bd&units=metric") else {
            fatalError("Missing weather URL")
        }
        
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            fatalError("Error fetching weather data.")
        }
        
        let decodedData = try JSONDecoder().decode(ResponseBody.self, from: data)
        return decodedData
    }
    
    func getFiveDayForecast(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> [ForecastResponse.Forecast] {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&appid=133a99cae05060e51c3f76f2a3bd53bd&units=metric") else {
            fatalError("Missing forecast URL")
        }
        
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            fatalError("Error fetching forecast data.")
        }
        
        let decodedData = try JSONDecoder().decode(ForecastResponse.self, from: data)
        
        return decodedData.list
    }
}


