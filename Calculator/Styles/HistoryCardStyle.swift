//
//  HistoryItemStyle.swift
//  Calculator
//
//  Created by Yegor Myropoltsev on 07.09.2023.
//

import SwiftUI

struct HistoryCardStyle: View {
    let historyItem: HistoryItem
    
    
    let cornerRadius = 16.0
    let cardHeight = 100.0
    var boxHeight: Double {
        cardHeight / 2.5
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
            .fill(Color("buttonColor"))
            .frame(maxWidth: .infinity, minHeight: cardHeight)
            .shadow(color: Color.gray, radius: 1)
            .overlay(
                VStack {
                    expressionInRectangle
                    resultInCard
                }
            )
            .padding(.horizontal)
    }
}

extension HistoryCardStyle {
    
    private var expressionInRectangle: some View {
        Rectangle()
            .fill(Color("cardHeadlineColor"))
            .frame(maxWidth: .infinity, maxHeight: boxHeight)
            .overlay(
                Text(historyItem.action)
                    .font(.headline)
                    .bold()
                    .foregroundColor(.primary)
            )
            .cornerRadius(cornerRadius, corners: [.topLeft, .topRight])
    }
    
    private var resultInCard: some View {
        VStack {
            Spacer()
            Text(historyItem.result)
                .font(.title)
                .foregroundColor(.primary)
            Spacer()
        }
    }

}


struct HistoryItemStyle_Previews: PreviewProvider {
    static var testHistoryItems: HistoryItem = HistoryItem(action: "10 * 2", result: "20")
    
    static var previews: some View {
        HistoryCardStyle(historyItem: testHistoryItems)
    }
}
