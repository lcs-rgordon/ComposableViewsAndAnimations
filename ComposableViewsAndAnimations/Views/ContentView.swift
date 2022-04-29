//
//  ContentView.swift
//  ComposableViewsAndAnimations
//
//  Created by Russell Gordon on 2021-02-23.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: Computed properties
    var body: some View {
        VStack {
            
            List {

                Section(header: Text("Basic Examples")) {

                    NavigationLink(destination: ImplicitAnimationsView()) {
                        
                        SimpleListItemView(title: "Implicit animations",
                                           caption: "Animating all state changes for a view")

                    }

                    NavigationLink(destination: ExplicitAnimationsView()) {
                        
                        SimpleListItemView(title: "Explicit animations",
                                           caption: "Animating only some state changes")

                    }

                }
                
                Section(header: Text("Exercises")) {
                    
                    NavigationLink(destination: ExercisesView()) {
                        
                        SimpleListItemView(title: "Exercises",
                                           caption: "Try making some of your own animations")

                    }

                }

                Section(header: Text("Reference")) {
                    
                    NavigationLink(destination: TimingView()) {
                        
                        SimpleListItemView(title: "Animation Timing",
                                           caption: "Different animation timings, illustrated")

                    }

                    
                    NavigationLink(destination: FontsView()) {
                        
                        SimpleListItemView(title: "Fonts",
                                           caption: "A complete list of fonts, or typefaces, available on iOS")

                    }

                    NavigationLink(destination: TutorialsView()) {
                        
                        SimpleListItemView(title: "Tutorials",
                                           caption: "Now you know the basics. Dig in here to learn more.")

                    }

                }
                
                Section(header: Text("Composable View Examples")) {

                    NavigationLink(destination: CompletionMeterDescriptionView()) {
                        
                        SimpleListItemView(title: "Completion Meter",
                                           caption: "This can be used to indicate progress")

                    }

                    NavigationLink(destination: EncouragementDescriptionView()) {
                        
                        SimpleListItemView(title: "Encouragement",
                                           caption: "Use this view to provide feedback to a user")

                    }
                    
                    NavigationLink(destination: LoadingIndicatorDescriptionView()) {
                        
                        SimpleListItemView(title: "Loading Indicator",
                                           caption: "Use this view to indicate that the app is busy")

                    }

                }
                
                Section(header: Text("Assignment")) {

                    NavigationLink(destination: CustomComposableDescriptionView()) {
                        
                        SimpleListItemView(title: "Create a composable view",
                                           caption: "Make your own reusable view using animations")

                    }

                }
                
            }
            .listStyle(GroupedListStyle())

        }
        .navigationTitle("Animations")
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
