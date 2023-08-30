//
//  Digit.swift
//  CalcYegor
//
//  Created by Yegor Myropoltsev on 28.08.2023.
//

import Foundation

enum Digit: Int, CaseIterable, CustomStringConvertible {
    case zero, one, two, three, four, five, six, seven, eight, nine
    
    var description: String {
        "\(rawValue)"
    }
}
