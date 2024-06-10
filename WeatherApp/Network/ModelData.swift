//
//  ModelData.swift
//  WeatherApp
//
//  Created by Vanessa Hurla on 23/05/2024.
//

// This struct organizes the logic for loading and processing weather data from JSON files into static methods and properties.

import Foundation

struct ModelData {
    static var previewWeather: ResponseBody = load("weatherData.json")
    static var previewForecast: [DailyForecast] = loadForecast("forecastData.json")
    
    
//Loads and decodes a JSON file from the main bundle.
    private static func load<T: Decodable>(_ filename: String) -> T {
        let data: Data
        
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
            fatalError("Couldn't find \(filename) in main bundle.")
        }
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
    }
    
// Loads and processes forecast data from a JSON file.
    private static func loadForecast(_ filename: String) -> [DailyForecast] {
        let data: Data
        
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
            fatalError("Couldn't find \(filename) in main bundle.")
        }
        
        do  {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }
        
        do {
            let decoder = JSONDecoder()
            let forecastResponse = try decoder.decode(ForecastResponse.self, from: data)
            
            let dailyForecasts = forecastResponse.list.map { forecast in
                DailyForecast(
                    date: Date(timeIntervalSince1970: TimeInterval(forecast.dt)),
                    maxTemp: forecast.main.temp_max,
                    weather: forecast.weather.first
                )
            }
            
            return groupForecastByDay(forecasts: dailyForecasts)
        } catch {
            fatalError("Couldn't parse \(filename) as \(ForecastResponse.self):\n\(error)")
        }
    }

// Groups the forecast data by day, ensuring that each day has the maximum temperature and corresponding weather.
    private static func groupForecastByDay(forecasts: [DailyForecast]) -> [DailyForecast] {
        var dailyForecasts: [String: DailyForecast] = [:]
        let currentDate = Date()
        let calendar = Calendar.current
        
        for forecast in forecasts {
            let date = forecast.date
            if calendar.isDate(date, inSameDayAs: currentDate) {
                continue
            }
            
            let dayString = dateFormattedForDay(date)
            
            if var dailyForecast = dailyForecasts[dayString] {
                if forecast.maxTemp > dailyForecast.maxTemp {
                    dailyForecast.maxTemp = forecast.maxTemp
                    dailyForecast.weather = forecast.weather
                }
                dailyForecasts[dayString] = dailyForecast
            } else {
                dailyForecasts[dayString] = DailyForecast(date: date, 
                                                          maxTemp: forecast.maxTemp,
                                                          weather: forecast.weather)
            }
        }
        
        return dailyForecasts.values.sorted { $0.date < $1.date }
    }
    
// Formats a Date object into a string representing the day in "yyyy-MM-dd" format.
    private static func dateFormattedForDay(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
}
