//
//  HapticEffectEasyWay.swift
//  Day49_PreProject10
//
//  Created by Bruno Oliveira on 18/05/24.
//

import SwiftUI

struct HapticEffectEasyWay: View {
    @State private var counter = 0
    @State private var counter1 = 0
    @State private var counter2 = 0
    
    var body: some View {
        Button("Tap Count: \(counter)") {
            counter += 1
        }
        .sensoryFeedback(.increase, trigger: counter)
        .padding()
        //.increase is one of the built-in haptic feedback variants, and is best used when you're increasing a value such as a counter. There are lots of others to choose from, including .success, .warning, .error, .start, .stop, and more.
        
        Button("Tap Count: \(counter1)") {
            counter1 += 1
        }
        .sensoryFeedback(.impact(flexibility: .soft, intensity: 0.5), trigger: counter1)
        .padding()
        //If you want a little more control over your haptic effects, there's an alternative called .impact(), which has two variants: one where you specify how flexible your object is and how strong the effect should be, and one where you specify a weight and intensity.
        
        Button("Tap Count: \(counter2)") {
            counter2 += 1
        }
        .sensoryFeedback(.impact(weight: .heavy, intensity: 1), trigger: counter2)
        .padding()
        //specifying an intense collision between two heavy objects
    
    }
}

#Preview {
    HapticEffectEasyWay()
}
