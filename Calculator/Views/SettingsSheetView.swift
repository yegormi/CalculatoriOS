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
            LazyHStack(spacing: 4) {
                ForEach(ColorPicker.allCases, id: \.self) { colorOption in
                    let isSelected = colorOption.color == viewModel.selectedColor.color
                    let labelColor = colorOption.description
                    let labelText = isSelected ? "\(labelColor)" : ""
                    
                    ColorCircle(colorSelected: colorOption,
                                isSelected: isSelected,
                                labelText: labelText)
                    .onTapGesture {
                        withAnimation(.easeOut(duration: Constants.animationDuration)) {
                            viewModel.setSelectedColor(to: colorOption)
                            viewModel.saveSelectedColor()
                        }
                    }
                }
                .padding(.bottom, 25)
            }
        }
    }
    
}
