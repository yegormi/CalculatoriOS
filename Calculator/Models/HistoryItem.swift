//
//  HistoryItem.swift
//  Calculator
//
//  Created by Yegor Myropoltsev on 07.09.2023.
//

import Foundation

struct HistoryItem: Identifiable, Decodable, Encodable {
    var id = UUID()
    let action: String
    let result: String
}
