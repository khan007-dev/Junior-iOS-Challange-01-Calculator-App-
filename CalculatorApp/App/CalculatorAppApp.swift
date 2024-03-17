//
//  CalculatorAppApp.swift
//  CalculatorApp
//
//  Created by Khan on 17.03.2024.
//

import SwiftUI

@main
struct CalculatorAppApp: App {
    var body: some Scene {
        WindowGroup {
            CalculatorHome()
                .environmentObject(Calculator())
        }
    }
}
