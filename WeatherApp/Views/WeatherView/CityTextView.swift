//
//  CityTextView.swift
//  WeatherApp
//
//  Created by Vanessa Hurla on 10/06/2024.
//

import SwiftUI

struct CityTextView: View {
    var cityName: String
    
    var body: some View {
        Text(cityName)
            .font(.system(size: 32, weight: .medium, design: .default))
            .foregroundStyle(.white)
            .padding()
    }
}
