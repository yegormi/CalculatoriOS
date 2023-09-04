//
//  ColorCircle.swift
//  ColorPicker
//
//  Created by Yegor Myropoltsev on 02.09.2023.
//


import SwiftUI

struct ColorCircle: View {
    let colorSelected: ColorPicker
    let isSelected: Bool


    var circleSize: CGFloat {
        return 20
    }
    
    var innerSize: CGFloat {
        return buttonSize / 2
    }
    
    var buttonSize: CGFloat {
        return getButtonSize()
    }
    
    var body: some View {
        ZStack {
            Circle()
                .fill(colorSelected.color)
                .frame(width: buttonSize, height: buttonSize)
            
            if isSelected {
                Circle()
                    .fill(Color.white)
                    .frame(width: innerSize, height: innerSize)
            }
        }
    }
    
    private func getButtonSize() -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let buttonCount: CGFloat = 7.0
        let spacingCount = buttonCount + 1
        return (screenWidth - (spacingCount * 12)) / buttonCount
    }
}
