//
//  LoadingIndicatorView.swift
//  ComposableViewsAndAnimations
//
//  Created by Russell Gordon on 2022-04-29.
//

import SwiftUI

struct LoadingIndicatorView: View {
    
    // MARK: Stored properties
    let duration: Double

    // MARK: Computed properties
    var body: some View {
        
        ZStack {
            Circle()
                .frame(width: 50, height: 50)
                .offset(x: 50, y: 0)
                .rotationEffect(.degrees(25), anchor: .center)
                .foregroundColor(.red)
            
            Circle()
                .frame(width: 50, height: 50)
                .offset(x: 0, y: 50)
                .rotationEffect(.degrees(25), anchor: .center)
                .foregroundColor(.green)

            Circle()
                .frame(width: 50, height: 50)
                .offset(x: -50, y: 0)
                .rotationEffect(.degrees(25), anchor: .center)
                .foregroundColor(.blue)

            Circle()
                .frame(width: 50, height: 50)
                .offset(x: 0, y: -50)
                .rotationEffect(.degrees(25), anchor: .center)
                .foregroundColor(.yellow)
        }
    }
}

struct LoadingIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingIndicatorView(duration: 1.0)
    }
}
