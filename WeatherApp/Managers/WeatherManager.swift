//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Vanessa Hurla on 22/05/2024.
//

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
    
    func getFiveDayForecast(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> ForecastResponse {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&appid=133a99cae05060e51c3f76f2a3bd53bd&units=metric") else {
            fatalError("Missing forecast URL")
        }
        
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            fatalError("Error fetching forecast data.")
        }
        
        let decodedData = try JSONDecoder().decode(ForecastResponse.self, from: data)
        
        return decodedData
    }
    
    // Group forecast data by day starting from the next day
    func groupForecastByDay(forecasts: [ForecastResponse.Forecast]) -> [ForecastResponse.Forecast] {
        var groupedForecasts: [String: ForecastResponse.Forecast] = [:]
        let currentDate = Date()
        let calendar = Calendar.current
        
        for forecast in forecasts {
            let date = Date(timeIntervalSince1970: TimeInterval(forecast.dt))
            if calendar.isDate(date, inSameDayAs: currentDate) {
                continue // Skip current day
            }
            
            let dayString = dateFormattedForDay(date)
            
            if var existingForecast = groupedForecasts[dayString] {
                if forecast.main.tempMax > existingForecast.main.tempMax {
                    existingForecast = forecast
                }
                groupedForecasts[dayString] = existingForecast
            } else {
                groupedForecasts[dayString] = forecast
            }
        }
        
        // Sort the grouped forecasts by date
        let sortedGroupedForecasts = groupedForecasts.values.sorted {
            $0.dt < $1.dt
        }
        
        return sortedGroupedForecasts
    }
    
    private func dateFormattedForDay(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
}

// Current weather response structure
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

// Forecast response structure
struct ForecastResponse: Decodable {
    let list: [Forecast]
    let city: City
    
    struct Forecast: Decodable {
        let dt: Int
        let main: Main
        let weather: [Weather]
        let clouds: Clouds
        let wind: Wind
        let visibility: Int
        let pop: Double
        let sys: Sys
        let dt_txt: String
        
        struct Main: Decodable {
            let temp: Double
            let feels_like: Double
            let temp_min: Double
            let temp_max: Double
            let pressure: Int
            let humidity: Int
        }
        
        struct Weather: Decodable {
            let id: Int
            let main: String
            let description: String
            let icon: String
        }
        
        struct Clouds: Decodable {
            let all: Int
        }
        
        struct Wind: Decodable {
            let speed: Double
            let deg: Int
        }
        
        struct Sys: Decodable {
            let pod: String
        }
    }
    
    struct City: Decodable {
        let id: Int
        let name: String
        let coord: Coord
        let country: String
        let population: Int
        let timezone: Int
        let sunrise: Int
        let sunset: Int
        
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
