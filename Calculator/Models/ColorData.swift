//
//  ColorData.swift
//  ColorPicker
//
//  Created by Yegor Myropoltsev on 02.09.2023.
//

import SwiftUI

enum ColorPicker: String, CaseIterable {
    case red
    case orange
    case green
    case blue
    case indigo
    case violet
    case pink
    case teal
    
    var color: Color {
        switch self {
        case .red:
            return Color.red
        case .orange:
            return Color.orange
        case .green:
            return Color.green
        case .blue:
            return Color.blue
        case .indigo:
            return Color.indigo
        case .violet:
            return Color.purple
        case .pink:
            return Color.pink
        case .teal:
            return Color.teal
        }
    }
    
    var description: String {
        return rawValue.capitalized
    }
}

