//
//  Extensions.swift
//  WeatherApp
//
//  Created by Vanessa Hurla on 23/05/2024.
//

// This extension contains a function that, when called, rounds the Double to zero decimals.


import Foundation

extension Double {
    func roundDouble() -> String {
        return String(format: "%.0f", self)
    }
}
