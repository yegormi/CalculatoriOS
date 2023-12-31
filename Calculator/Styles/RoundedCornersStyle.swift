//
//  RoundedCornersStyle.swift
//  Calculator
//
//  Created by Yegor Myropoltsev on 05.09.2023.
//

import SwiftUI

extension View {
    func cornerRadius(_ radius: Double, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {
    
    var radius: Double = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
