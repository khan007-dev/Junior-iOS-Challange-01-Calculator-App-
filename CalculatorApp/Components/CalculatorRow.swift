//
//  CalculatorRow.swift
//  CalculatorApp
//
//  Created by Khan on 17.03.2024.
//

import SwiftUI



struct CalculatorRow: View {
    var labels = ["", "", "", ""]
    var colors: [Color] = [.gray, .gray, .gray, .orange]
    let columnCount = 4
    
    var body: some View {
       
        HStack (spacing: 10) {
            
            ForEach(0..<columnCount) { index in
            
                CalculatorButton(label: labels[index], color: colors[index])
                
            }
            
        }
    }
}

#Preview {
    CalculatorRow(labels: ["1","2","3","4"])
       
}
