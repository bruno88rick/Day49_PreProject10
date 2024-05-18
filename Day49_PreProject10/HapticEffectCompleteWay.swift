//
//  HapticEffectCompleteWay.swift
//  Day49_PreProject10
//
//  Created by Bruno Oliveira on 18/05/24.
//

import SwiftUI
import CoreHaptics

struct HapticEffectCompleteWay: View {
    //we need to create an instance of CHHapticEngine as a property – this is the actual object that’s responsible for creating vibrations, so we need to create it up front before we want haptic effects.
    @State private var engine: CHHapticEngine?
    
    var body: some View {
        VStack {
            Button("Tap me", action: complexSuccess)
                .padding()
            Button("Play Haptics", action: moreComplexSuccess)
                .onAppear(perform: prepareHaptics)
        }
        .padding()
    }
    
    /*In this method below, We’re going to create that as soon as our main view appears. When creating the engine you can attach handlers to help resume activity if it gets stopped, such as when the app moves to the background, but here we’re going to keep it simple: if the current device supports haptics we’ll start the engine, and print an error if it fails.*/
    
    func prepareHaptics() {
        //verifying if device supports haptics, otherwise, return
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {return}
        
        //trying to start the engine
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }
    
    /*In this method below, we can configure parameters that control how strong the haptic should be (.hapticIntensity) and how “sharp” it is (.hapticSharpness), then put those into a haptic event with a relative time offset. “Sharpness” is an odd term, but it will make more sense once you’ve tried it out – a sharpness value of 0 really does feel dull compared to a value of 1. As for the relative time, this lets us create lots of haptic events in a single sequence.*/
    
    func complexSuccess() {
        //make sure that the device supports haptics
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {return}
        //creating an empty Haptic Event array
        var events = [CHHapticEvent]()
        
        //create one intense, sharp tap
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness , value: 1)
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
        events.append(event)
    
        //convert those events into a pattern and play it immediately
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Faild to play patter: \(error.localizedDescription)")
        }
    }
    
    func moreComplexSuccess(){
        //make sure that the device supports haptics
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {return}
        //creating an empty Haptic Event array
        var events = [CHHapticEvent]()
        
        for i in stride(from: 0, to: 1, by: 0.1){
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity ,value: Float(i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticIntensity ,value: Float(i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
            events.append(event)
        }
        
        for i in stride(from: 0, to: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1 - i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1 - i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 1 + i)
            events.append(event)
        }
        
        //convert those events into a pattern and play it immediately
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Faild to play patter: \(error.localizedDescription)")
        }
        
    }
}

#Preview {
    HapticEffectCompleteWay()
}
