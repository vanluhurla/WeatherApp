//
//  ModelData.swift
//  WeatherApp
//
//  Created by Vanessa Hurla on 23/05/2024.
//

import Foundation

var previewWeather: ResponseBody = load("weatherData.json")
var previewForecast: [ForecastResponse.Forecast] = (load("forecastData.json") as ForecastResponse).list

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
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

func loadForecast<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }

    do  {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}




//let previewForecast = [
//    ForecastResponse.Forecast(dt: 1685390400, main: .init(temp: 18, feels_like: 18, temp_min: 18, temp_max: 18, pressure: 1016, humidity: 85), weather: [.init(id: 800, main: "Clear", description: "clear sky", icon: "01d")], clouds: .init(all: 1), wind: .init(speed: 4.12, deg: 310), visibility: 10000, pop: 0, sys: .init(pod: "d"), dt_txt: "2023-05-30 09:00:00"),
//    ForecastResponse.Forecast(dt: 1685476800, main: .init(temp: 20, feels_like: 20, temp_min: 20, temp_max: 20, pressure: 1016, humidity: 85), weather: [.init(id: 800, main: "Clear", description: "clear sky", icon: "01d")], clouds: .init(all: 1), wind: .init(speed: 4.12, deg: 310), visibility: 10000, pop: 0, sys: .init(pod: "d"), dt_txt: "2023-05-31 09:00:00"),
//    ForecastResponse.Forecast(dt: 1685563200, main: .init(temp: 22, feels_like: 22, temp_min: 22, temp_max: 22, pressure: 1016, humidity: 85), weather: [.init(id: 800, main: "Clear", description: "clear sky", icon: "01d")], clouds: .init(all: 1), wind: .init(speed: 4.12, deg: 310), visibility: 10000, pop: 0, sys: .init(pod: "d"), dt_txt: "2023-06-01 09:00:00"),
//    ForecastResponse.Forecast(dt: 1685649600, main: .init(temp: 19, feels_like: 19, temp_min: 19, temp_max: 19, pressure: 1016, humidity: 85), weather: [.init(id: 800, main: "Clear", description: "clear sky", icon: "01d")], clouds: .init(all: 1), wind: .init(speed: 4.12, deg: 310), visibility: 10000, pop: 0, sys: .init(pod: "d"), dt_txt: "2023-06-02 09:00:00"),
//    ForecastResponse.Forecast(dt: 1685736000, main: .init(temp: 21, feels_like: 21, temp_min: 21, temp_max: 19, pressure: 1016, humidity: 85), weather: [.init(id: 800, main: "Clear",
//        description: "clear sky", icon: "01d")], clouds: .init(all: 1), wind: .init(speed: 4.12, deg: 310), visibility: 10000, pop: 0, sys: .init(pod: "d"), dt_txt: "2023-06-03 09:00:00")
//    ]
