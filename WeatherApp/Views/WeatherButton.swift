//
//  WeatherButton.swift
//  WeatherApp
//
//  Created by Vanessa Hurla on 20/05/2024.
//

import SwiftUI

struct WeatherButton: View {
  
    var title: String
    var textColour: Color
    var backgroundColour: Color
    
    var body: some View {
        Text(title)
            .frame(width: 280, height: 50)
            .background(backgroundColour)
            .foregroundColor(textColour)
            .font(.system(size: 20, weight: .bold, design: .default))
            .cornerRadius(10)
    }
}
