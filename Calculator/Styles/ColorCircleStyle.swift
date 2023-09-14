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
    let labelText: String
    
    let circleSize: CGFloat = 20
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
                .overlay(
                    isSelected ?
                        Circle()
                            .fill(Color.white)
                            .frame(width: innerSize, height: innerSize) : nil
                    
                )
            Text(labelText)
                .font(.system(size: 15, weight: .regular))
                .foregroundColor(Color.gray)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .offset(y: circleSize * 2)
        }
        .frame(minWidth: buttonSize + Constants.spacing / 1.3)
    }
    
    private func getButtonSize() -> Double {
        let screenWidth = UIScreen.main.bounds.width
        let buttonCount = 7.0
        let spacingCount = buttonCount + 1
        return (screenWidth - (spacingCount * 12)) / buttonCount
    }
}

struct ColorCircle_Previews: PreviewProvider {
    static var previews: some View {
        LazyHStack(spacing: 15) {
            Group {
                ColorCircle(colorSelected: .red, isSelected: false, labelText: "Red")
                    .previewLayout(.sizeThatFits)
                
                ColorCircle(colorSelected: .orange, isSelected: true, labelText: "Orange")
                    .previewLayout(.sizeThatFits)
            }
        }
        .previewLayout(PreviewLayout.sizeThatFits)
        .padding()
        .previewDisplayName("Default preview")
    }
}

