//
//  ButtonType.swift
//  CalcYegor
//
//  Created by Yegor Myropoltsev on 28.08.2023.
//

import SwiftUI

enum ButtonType: Hashable, CustomStringConvertible {
    case digit(_ digit: Digit)
    case operation(_ operation: ArithmeticOperation)
    case negative
    case percent
    case decimal
    case equals
    case allClear
    case clear
    
    var description: String {
        switch self {
        case .digit(let digit):
            return digit.description
        case .operation(let operation):
            return operation.description
        case .negative:
            return "±"
        case .percent:
            return "%"
        case .decimal:
            return "."
        case .equals:
            return "="
        case .allClear:
            return "AC"
        case .clear:
            return "C"
        }
    }
    
    
    var backgroundColor: Color {
        switch self {
        case .allClear, .clear, .negative, .percent:
            return Color(.lightGray)
        case .operation, .equals:
            return SettingsView.ViewModel().selectedColor.color
        case .digit, .decimal:
            return Color("buttonColor")
        }
    }
    
    var foregroundColor: Color {
        switch self {
        case .allClear, .clear, .negative, .percent:
            return .black
        case .digit, .decimal:
            return Color("fontColor")
        default:
            return .white
        }
    }
}
