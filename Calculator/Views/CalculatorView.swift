//
//  CalculatorView.swift
//  CalcYegor
//
//  Created by Yegor Myropoltsev on 28.08.2023.
//

import SwiftUI


// MARK: - BODY

struct CalculatorView: View {
    
    @EnvironmentObject private var viewModel: ViewModel
    @EnvironmentObject private var settingsViewModel: SettingsView.ViewModel
    
    @State private var isShowingSettings = false
    @State private var isShowingHistory = false
    @State private var isReadyToUpdateView = false
    
    


    var body: some View {
        VStack {
            HStack {
                settingsButton
                    .padding(Constants.padding)
                Spacer()
                historyButton
                    .padding(Constants.padding)
            }
            Spacer()
            displayText
            buttonPad
        }
        .padding(Constants.padding)
        .background(Color(UIColor.systemBackground))
//        .onChange(of: settingsViewModel.isDarkModeEnabled) { newValue in
//            applyDarkModeTransition(newValue)
//        }
        .onReceive(settingsViewModel.accentColorChanged) { _ in
            isReadyToUpdateView = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                isReadyToUpdateView = false
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
            .foregroundColor(.primary)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .font(.system(size: 88, weight: .light))
            .lineLimit(1)
            .minimumScaleFactor(0.3)
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
                .foregroundColor(.primary)
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
                .foregroundColor(.primary)
        }
    }
    
    private func applyDarkModeTransition(_ isDarkModeEnabled: Bool) {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
                window.overrideUserInterfaceStyle = isDarkModeEnabled ? .dark : .light
            }, completion: nil)
        }
    }
}
