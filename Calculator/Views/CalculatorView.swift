//
//  CalculatorView.swift
//  CalcYegor
//
//  Created by Yegor Myropoltsev on 28.08.2023.
//

import SwiftUI


// MARK: - BODY

struct CalculatorView: View {
    
    @EnvironmentObject var viewModel: ViewModel
    @EnvironmentObject var settingsViewModel: SettingsView.ViewModel
    @State private var isShowingSettings = false
    @State private var isShowingHistory = false
    @State private var isReadyToUpdateView = false


    var body: some View {
        NavigationView {
                VStack {
                    Spacer()
                    displayText
                    buttonPad
                }
                .padding(Constants.padding)
                .background(Color.black)
                .onChange(of: settingsViewModel.isDarkModeEnabled) { newValue in
                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                       let window = windowScene.windows.first {
                        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
                            window.overrideUserInterfaceStyle = newValue ? .dark : .light
                        }, completion: nil)
                    }
                }
                .onAppear() {
                    settingsViewModel.selectedColor = settingsViewModel.storedSelectedColor
                }
                .onChange(of: settingsViewModel.selectedColor) { newValue in
                    settingsViewModel.setSelectedColor(to: newValue)
                    settingsViewModel.saveSelectedColor()
                }
                .onReceive(settingsViewModel.accentColorChanged) { _ in
                    isReadyToUpdateView = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        isReadyToUpdateView = false
                    }
                }
                .toolbar() {
                    ToolbarItem(placement: .navigationBarLeading) {
                        settingsButton.padding(.top)
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        historyButton.padding(.top)
                    }
                    
                }
        }
    }
}



// MARK: - PREVIEWS

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
            .environmentObject(CalculatorView.ViewModel())
            .environmentObject(SettingsView.ViewModel())
    }
}

// MARK: - COMPONENTS

extension CalculatorView {
    
    private var displayText: some View {
        Text(viewModel.displayText)
            .padding()
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .font(.system(size: 88, weight: .light))
            .lineLimit(1)
            .minimumScaleFactor(0.5)
    }
    
    private var buttonPad: some View {
        Group {
            VStack(spacing: Constants.padding) {
                ForEach(viewModel.buttonTypes, id: \.self) { row in
                    HStack(spacing: Constants.padding) {
                        ForEach(row, id: \.self) { buttonType in
                            CalculatorButton(buttonType: buttonType)
                        }
                    }
                }
            }
        }
        .id(isReadyToUpdateView)

    }

    
    private var settingsButton: some View {
        Button(action: {
            isShowingSettings.toggle()
        }) {
            Image(systemName: "gearshape")
                .font(.title)
                .foregroundColor(.white)
        }
        .sheet(isPresented: $isShowingSettings) {
            SettingsView()
        }
    }
    
    private var historyButton: some View {
        Button(action: {
            isShowingHistory.toggle()
        }) {
            Image(systemName: "clock.arrow.circlepath")
                .font(.title)
                .foregroundColor(.white)
        }
    }
}
