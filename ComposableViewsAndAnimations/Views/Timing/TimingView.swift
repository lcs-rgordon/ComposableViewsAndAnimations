//
//  TimingView.swift
//  ComposableViewsAndAnimations
//
//  Created by Russell Gordon on 2021-02-23.
//

//
//  ContentView.swift
//  AnimationTimingCurve
//
//  Created by Chris Eidhof on 25.09.19.
//  Copyright © 2019 Chris Eidhof. All rights reserved.
//

import SwiftUI

struct RecordTimingCurve: GeometryEffect {
    var onChange: (CGFloat) -> () = { _ in () }
    var animatableData: CGFloat = 0 {
        didSet {
            onChange(animatableData)
        }
    }
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        return .init()
    }
}

import Combine

final class AnimationTrace: ObservableObject {
    let objectWillChange = PassthroughSubject<(), Never>()
    var data: [(time: CFTimeInterval, value: CGFloat)] = []
    
    var startTime: CFTimeInterval {
        data.first?.time ?? 0
    }
    
    var endTime: CFTimeInterval {
        data.last?.time ?? 0
    }
        
    func record(_ value: CGFloat) {
        data.append((CACurrentMediaTime(), value))
//        if value == 1 {
            DispatchQueue.main.async {
                print("Data count: \(self.data.count)")
                self.objectWillChange.send()
            }
//        }
    }
    func reset() {
        data = []
    }
}

struct Trace: Shape {
    var values: [(CGFloat, CGFloat)] // the second component should be in range 0...1
    
    func path(in rect: CGRect) -> Path {
        guard let f = values.first, let l = values.last else { return Path() }
        let xOffset = f.0
        let xMultiplier = l.0 - f.0
        return Path { p in
            p.move(to: CGPoint(x: rect.minX, y: rect.maxY))
            for value in values {
                let point = CGPoint(x: rect.minX + ((value.0 - xOffset) / xMultiplier) * rect.width, y: rect.maxY - CGFloat(value.1) * rect.height)
                p.addLine(to: point)
            }
        }
    }
    
}

let animations: [(String, Animation)] = [
    ("default", .default),
    ("linear(duration: 1)", .linear(duration: 1)),
    ("interpolatingSpring(stiffness: 5, damping: 3)", .interpolatingSpring(stiffness: 5, damping: 3)),
    (".easeInOut(duration: 1)", .easeInOut(duration: 1)),
    (".easeIn(duration: 1)", .easeIn(duration: 1)),
    (".easeOut(duration: 1)", .easeOut(duration: 1)),
    (".interactiveSpring(response: 3, dampingFraction: 2, blendDuration: 1)", .interactiveSpring(response: 3, dampingFraction: 2, blendDuration: 1)),
    (".spring", .spring()),
    (".default.repeatCount(3)", Animation.default.repeatCount(3)),
]

struct TimingView: View {
    @ObservedObject var trace = AnimationTrace()
    @State var animating: Bool = false
    @State var selectedAnimationIndex: Int = 0
    @State var slowAnimations: Bool = false
    var selectedAnimation: (String, Animation) {
        return animations[selectedAnimationIndex]
    }
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.pink)
                .frame(width: 50, height: 50)
                .offset(x: animating ? 100 : -100)
                .modifier(RecordTimingCurve(onChange: {
                    self.trace.record($0)
                }, animatableData: animating ? 1 : 0))
            VStack {
                         Trace(values: trace.data.map {
                             (CGFloat($0), $1)
                         })
                             .stroke(Color.red, style: .init(lineWidth: 2))
                             .frame(height: 150)
                             .background(Rectangle().stroke(Color.gray, style: .init(lineWidth: 1)))
                         HStack {
                             Text("0")
                             Spacer()
                             Text("\(trace.endTime - trace.startTime)")
                             
                         }
                     }.frame(width: 200)
            
            Spacer()
            Picker(selection: $selectedAnimationIndex, label: EmptyView(), content: {
                ForEach(0..<9) {
                    Text(animations[$0].0)
                }
            })
            .pickerStyle(.wheel)
            
            Button(action: {
                self.animating = false
                self.trace.reset()
                withAnimation(self.selectedAnimation.1.speed(self.slowAnimations ? 0.25 : 1), {
                    self.animating = true
                })
            }, label: { Text("Animate") })
            Toggle(isOn: $slowAnimations, label: { Text("Slow Animations") })
        }
        .navigationTitle("Animation Timing")
    }
}

struct TimingView_Previews: PreviewProvider {
    static var previews: some View {
        TimingView()
    }
}
