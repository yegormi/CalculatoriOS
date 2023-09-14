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
                }
            }
            .navigationTitle("Preferences")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(SettingsView.ViewModel())
    }
}

extension SettingsView {
    
    private var circlesScrollablePicker: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 15) {
                ForEach(ColorPicker.allCases, id: \.self) { colorOption in
                    let isSelected = colorOption.color == viewModel.selectedColor.color
                    
                    let labelColor = colorOption.color.description.capitalized
                    let labelText = isSelected ? "\(labelColor)" : ""
                    
                    ColorCircle(colorSelected: colorOption,
                                isSelected: isSelected,
                                labelText: labelText)
                    .onTapGesture {
                        withAnimation(.easeOut(duration: 0.3)) {
                            viewModel.setSelectedColor(to: colorOption)
                            viewModel.saveSelectedColor()
                        }
                    }
                }
                .padding(.bottom, 25)
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
