//
//  LoadingIndicatorDescriptionView.swift
//  ComposableViewsAndAnimations
//
//  Created by Russell Gordon on 2022-04-29.
//

import SwiftUI

struct LoadingIndicatorDescriptionView: View {
    
    // MARK: Stored properties
    @State var animationDuration = 1.0
    
    // MARK: Computed properties
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Group {
                
                Text("Description")
                    .font(.title2)
                    .bold()
                    .padding(.top)
                
                Text("""
                    This view can be used to indicate that a user should wait for the app to complete a task.
                    
                    You can control the duration of the animation using the slider below, whose value is passed as an argument to the view.
                    """)
                .minimumScaleFactor(0.5)
                
                HStack {
                    
                    Text("1")
                        .font(.caption)
                    
                    Slider(value: $animationDuration, in: 1...5, step: 0.25) {
                        Text("Animation duration")
                    }

                    Text("5")
                        .font(.caption)

                }
                                    
            }
            .padding(.bottom)
            
            List {
                NavigationLink(destination: LoadingIndicatorView(duration: animationDuration)) {
                    SimpleListItemView(title: "Loading Indicator",
                                       caption: "Will take \(String(format: "%.2f", animationDuration)) second(s) to complete one revolution.")
                }
            }

        }
        .padding()
        .navigationTitle("Completion Meter")
        
    }
    
}

struct LoadingIndicatorDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingIndicatorDescriptionView()
    }
}
