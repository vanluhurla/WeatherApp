//
//  LoadingView.swift
//  WeatherApp
//
//  Created by Vanessa Hurla on 22/05/2024.
//

// The LoadingView struct defines a user interface component for displaying a loading indicator.

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: .white))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    LoadingView()
}
