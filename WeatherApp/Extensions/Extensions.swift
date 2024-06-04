//
//  Extensions.swift
//  WeatherApp
//
//  Created by Vanessa Hurla on 23/05/2024.
//

import Foundation

// This extension contains a function that, when called, rounds the Double to zero decimals.

extension Double {
    func roundDouble() -> String {
        return String(format: "%.0f", self)
    }
}
