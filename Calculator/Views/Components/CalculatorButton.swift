//
//  CalculatorButton.swift
//  CalcYegor
//
//  Created by Yegor Myropoltsev on 28.08.2023.
//

import SwiftUI

extension CalculatorView {
    struct CalculatorButton: View {
        
        let buttonType: ButtonType
        @EnvironmentObject var viewModel: ViewModel
        @Environment(\.colorScheme) var colorScheme
        
        
        var body: some View {
            Button(buttonType.description) {
                viewModel.performAction(for: buttonType)
            }
            .buttonStyle(CalculatorButtonStyle(
                size: getButtonSize(),
                backgroundColor: getBackgroundColor(),
                foregroundColor: getForegroundColor(),
                isWide: buttonType == .digit(.zero))
            )
            .shadow(color: shadowColor, radius: 4, x: 0, y: 0)
            
        }
        
        private var shadowColor: Color{
            return colorScheme == .dark ? .clear : .gray
        }
        
        private func getButtonSize() -> CGFloat {
            let screenWidth = UIScreen.main.bounds.width
            let buttonCount: CGFloat = 4.0
            let spacingCount = buttonCount + 1
            return (screenWidth - (spacingCount * Constants.padding)) / buttonCount
        }
        
        // MARK: HELPERS
        private func getBackgroundColor() -> Color {
            return viewModel.buttonTypeIsHighlighted(buttonType: buttonType) ? buttonType.foregroundColor : buttonType.backgroundColor
        }
        
        private func getForegroundColor() -> Color {
            return viewModel.buttonTypeIsHighlighted(buttonType: buttonType) ? buttonType.backgroundColor : buttonType.foregroundColor
        }
    }
}
