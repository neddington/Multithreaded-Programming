//
//  ContentView.swift
//  Multithreaded Programming
//
//  Created by Eddington, Nick on 11/6/23.
//

import SwiftUI

struct ContentView: View {
    // State variables to track the app's state
    @State private var isWorking = false
    @State private var progress: Double = 0.0
    
    var body: some View {
        VStack {
            Text("Long-Running Work Example")
                .font(.largeTitle)
                .padding()
            
            // Button to start the long-running work
            Button(action: {
                self.startLongRunningTask()
            }) {
                Text("Start Long Work")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            // Slider to show progress
            Slider(value: $progress, in: 0...1)
                .padding()
                .disabled(isWorking) // Disable the slider when work is in progress
        }
    }
    
    // Function to simulate long-running work
    func startLongRunningTask() {
        isWorking = true
        DispatchQueue.global().async {
            for i in 1...100 {
                // Simulate work by sleeping for a short time
                usleep(100_000) // Sleep for 100ms
                DispatchQueue.main.async {
                    // Update the progress on the main thread
                    self.progress = Double(i) / 100.0
                }
            }
            DispatchQueue.main.async {
                isWorking = false
            }
        }
    }
}
#Preview {
    ContentView()
}
