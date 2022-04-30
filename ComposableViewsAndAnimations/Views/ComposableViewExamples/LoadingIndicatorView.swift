//
//  LoadingIndicatorView.swift
//  ComposableViewsAndAnimations
//
//  Created by Russell Gordon on 2022-04-29.
//

import SwiftUI

struct LoadingIndicatorView: View {
    
    // MARK: Stored properties
    
    // How much the circles will spread out
    let spread: Double
    
    // How far circles will move in
    let homePosition = 0.0
    
    // Whether the circles are spread out or not
    @State var circlesSpreadOut = true
    
    // Rotations
    @State var clockwiseRotation = 0.0
    @State var counterClockwiseRotation = 0.0

    // Timer fires every quarter second
    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()

    // MARK: Computed properties
    var body: some View {
        
        ZStack {
            Circle()
                .frame(width: 50, height: 50)
                .offset(x: circlesSpreadOut ? 1 * spread : homePosition, y: 0)
                .rotationEffect(.degrees(clockwiseRotation), anchor: .center)
                .foregroundColor(.red)
            
            Circle()
                .frame(width: 50, height: 50)
                .offset(x: 0, y: circlesSpreadOut ? 1 * spread : homePosition)
                .rotationEffect(.degrees(counterClockwiseRotation), anchor: .center)
                .foregroundColor(.green)

            Circle()
                .frame(width: 50, height: 50)
                .offset(x: circlesSpreadOut ? -1 * spread : homePosition, y: 0)
                .rotationEffect(.degrees(clockwiseRotation), anchor: .center)
                .foregroundColor(.blue)

            Circle()
                .frame(width: 50, height: 50)
                .offset(x: 0, y: circlesSpreadOut ? -1 * spread: homePosition)
                .rotationEffect(.degrees(counterClockwiseRotation), anchor: .center)
                .foregroundColor(.yellow)
        }
        .onReceive(timer) { input in

            withAnimation(
                Animation
                    .easeInOut(duration: 0.5)
            ) {
                // Make the circles spread out (or not)
                circlesSpreadOut.toggle()
                
                // Rotate the circles
                clockwiseRotation += 45
                print("Clockwise rotation value: \(clockwiseRotation)")
                counterClockwiseRotation -= 45
                print("Counter clockwise rotation value: \(counterClockwiseRotation)")

            }
            
        }
    }
}

struct LoadingIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingIndicatorView(spread: 50.0)
    }
}
