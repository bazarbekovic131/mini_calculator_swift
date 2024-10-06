//
//  ContentView.swift
//  Mini Calculator
//
//  Created by Akha on 06.10.2024.
//

import SwiftUI

struct ContentView: View {
    @State var showSecretView: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                // Pass the binding to CalculatorView
                CalculatorView(showSecretView: $showSecretView)
                    .navigationBarHidden(true)
            }
            // Use navigationDestination to handle conditional navigation
            .navigationDestination(isPresented: $showSecretView) {
                SecretView() // Destination when showSecretView is true
            }
        }
    }
}

#Preview {
    ContentView()
}
