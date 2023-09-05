//
//  SettingsView.swift
//  Settings
//
//  Created by Yegor Myropoltsev on 02.09.2023.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var viewModel: SettingsView.ViewModel

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Accent Color")) {
                    circlesScrollablePicker
                        .padding(5)
//                  Text("Stored Color: \(viewModel.storedSelectedColor.description)")
//                    darkMode
                        .padding(5)
                }
            }
            .navigationTitle("Preferences")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(CalculatorView.ViewModel())
            .environmentObject(SettingsView.ViewModel())
    }
}

extension SettingsView {
    
    private var circlesScrollablePicker: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 15) {
                ForEach(ColorPicker.allCases, id: \.self) { colorOption in
                    ColorCircle(colorSelected: colorOption, isSelected: colorOption.color == viewModel.selectedColor.color)
                        .onTapGesture {
                            withAnimation() {
                                viewModel.setSelectedColor(to: colorOption)
                            }
                            viewModel.saveSelectedColor()
                        }
                    
                }
            }
        }
    }
    
    private var darkMode: some View {
        HStack {
            Image(systemName: "moon")
            Toggle("Dark Mode", isOn: $viewModel.isDarkModeEnabled)
        }

    }
    
}
