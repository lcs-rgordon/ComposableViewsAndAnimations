//
//  LoadingIndicatorDescriptionView.swift
//  ComposableViewsAndAnimations
//
//  Created by Russell Gordon on 2022-04-29.
//

import SwiftUI

struct LoadingIndicatorDescriptionView: View {
    
    // MARK: Stored properties
    @State var spreadValue = 75.0
    
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
                    
                    You can control how much the circles spread out using the slider, whose value is passed as an argument to the view.
                    """)
                .minimumScaleFactor(0.5)
                
                HStack {
                    
                    Text("50")
                        .font(.caption)
                    
                    Slider(value: $spreadValue, in: 50...100, step: 1.0) {
                        Text("Spread value")
                    }

                    Text("100")
                        .font(.caption)

                }
                                    
            }
            .padding(.bottom)
            
            List {
                NavigationLink(destination: LoadingIndicatorView(spread: spreadValue)) {
                    SimpleListItemView(title: "Loading Indicator",
                                       caption: "Circles will move \(String(format: "%.2f", spreadValue)) pixels from the centre of the view.")
                }
            }

        }
        .padding()
        .navigationTitle("Loading Indicator")
        
    }
    
}

struct LoadingIndicatorDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingIndicatorDescriptionView()
    }
}
