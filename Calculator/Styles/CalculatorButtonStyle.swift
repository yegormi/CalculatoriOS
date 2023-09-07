//
//  CalculatorButtonStyle.swift
//  CalcYegor
//
//  Created by Yegor Myropoltsev on 28.08.2023.
//

import SwiftUI

struct CalculatorButtonStyle: ButtonStyle {
    
    var size: CGFloat
    var backgroundColor: Color
    var foregroundColor: Color
    var isWide: Bool = false
    
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 35, weight: .regular))
            .frame(width: size, height: size)
            .frame(maxWidth: isWide ? .infinity : size, alignment: .leading)
            .background(backgroundColor)
            .foregroundColor(foregroundColor)
            .overlay {
                if configuration.isPressed {
                    //                        Color(white: 1.0, opacity: 0.2)
                    Color("highlightColor").opacity(0.2)
                }
            }
            .clipShape(Capsule())
    }
}

struct CalculatorButtonStyle_Previews: PreviewProvider {
    static let buttonType: ButtonType = .operation(ArithmeticOperation.multiplication)
    
    static var previews: some View {
        Button(buttonType.description) { }
            .buttonStyle(CalculatorButtonStyle(
                size: 80,
                backgroundColor: buttonType.backgroundColor,
                foregroundColor: buttonType.foregroundColor)
            )
    }
}
