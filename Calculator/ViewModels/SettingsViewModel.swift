//
//  SettingsPickerViewModel.swift
//  SettingsPicker
//
//  Created by Yegor Myropoltsev on 02.09.2023.
//

import SwiftUI
import Combine

extension SettingsView {
    
    
    final class ViewModel: ObservableObject {
        
        @Published var selectedColor: ColorPicker = .orange

        @AppStorage("isDarkModeEnabled") var isDarkModeEnabled = false
        @AppStorage("selectedColor") var storedSelectedColor: ColorPicker = .orange

        // Add an accent color change publisher
        let accentColorChanged = PassthroughSubject<Void, Never>()
        
        init() {
            selectedColor = storedSelectedColor
        }
        
        func setSelectedColor(to newColor: ColorPicker) {
            selectedColor = newColor
            accentColorChanged.send() // Notify subscribers about the change
        }
        
        func saveSelectedColor() {
            storedSelectedColor = selectedColor
        }
    }
}
