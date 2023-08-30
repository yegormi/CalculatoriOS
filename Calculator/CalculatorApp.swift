//
//  CalculatorApp.swift
//  Calculator
//
//  Created by Yegor Myropoltsev on 28.08.2023.
//

import SwiftUI

@main
struct CalculatorApp: App {
    var body: some Scene {
        WindowGroup {
            CalculatorView()
                .environmentObject(CalculatorView.ViewModel())
        }
    }
}
