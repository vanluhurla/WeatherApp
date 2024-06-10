//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Vanessa Hurla on 10/06/2024.
//

import Foundation

// Daily forecast weather response

struct DailyForecast: Identifiable {
    var id = UUID()
    var date: Date
    var maxTemp: Double
    var weather: ForecastResponse.Forecast.Weather?
}

// Current weather response

struct ResponseBody: Decodable {
    var coord: CoordinatesResponse
    var weather: [WeatherResponse]
    var main: MainResponse
    var name: String // city name
    
    struct CoordinatesResponse: Decodable {
        var lon: Double
        var lat: Double
    }
    
    struct WeatherResponse: Decodable {
        var id: Double
        var main: String
        var description: String
        var icon: String
    }
    
    struct MainResponse: Decodable {
        var temp: Double
        var feels_like: Double
        var temp_min: Double
        var temp_max: Double
    }
}

extension ResponseBody.MainResponse {
    var feelsLike: Double { return feels_like }
    var tempMin: Double { return temp_min }
    var tempMax: Double { return temp_max }
}

// Forecast response

struct ForecastResponse: Decodable {
    let list: [Forecast]
    let city: City
    
    struct Forecast: Decodable {
        let dt: Int
        let main: Main
        let weather: [Weather]
        let dt_txt: String
        
        struct Main: Decodable {
            let temp: Double
            let feels_like: Double
            let temp_min: Double
            let temp_max: Double
        }
        
        struct Weather: Decodable {
            let id: Int
            let main: String
            let description: String
            let icon: String
        }
    }
    
    struct City: Decodable {
        let id: Int
        let name: String
        let coord: Coord
        let country: String
        let timezone: Int
        
        struct Coord: Decodable {
            let lat: Double
            let lon: Double
        }
    }
}

extension ForecastResponse.Forecast.Main {
    var feelsLike: Double { return feels_like }
    var tempMin: Double { return temp_min }
    var tempMax: Double { return temp_max }
}
