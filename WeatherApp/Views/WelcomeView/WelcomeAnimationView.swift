//
//  AnimationView.swift
//  WeatherApp
//
//  Created by Vanessa Hurla on 05/06/2024.
//

// This struct defines a SwiftUI view called LoadingAnimationView that displays a Lottie animation.

import SwiftUI
import Lottie

struct WelcomeAnimationView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        let animationView = LottieAnimationView(name: "weatherAnimation")
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 0.5
        animationView.play()
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14)
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}

#Preview {
    WelcomeAnimationView()
}
