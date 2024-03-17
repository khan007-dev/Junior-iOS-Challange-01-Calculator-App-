//
//  CalculatorButton.swift
//  CalculatorApp
//
//  Created by Khan on 17.03.2024.
//

import SwiftUI

struct CalculatorButton: View {
    var label: String
    var color: Color
    @EnvironmentObject var calculator: Calculator
    var body: some View {
        
        VStack {
            
            Button {
            // inform model for button press
                calculator.buttonPressed(lable: label)
            } label: {
                ZStack {
                    Circle()
                        .fill(color)
                    Text(label)
                        .font(.title)
                }
            }
            .accentColor(.white)

        }
    }
}

#Preview {
    CalculatorButton(label: "1", color: .gray)
        .previewLayout(.fixed(width: 100, height: 100))
        .environmentObject(Calculator())
    
}
