//
//  HistoryView.swift
//  Calculator
//
//  Created by Yegor Myropoltsev on 05.09.2023.
//

import SwiftUI

struct HistoryItem: Identifiable, Decodable, Encodable {
    var id = UUID()
    let action: String
    let result: String
}

struct HistoryCardView: View {
    @EnvironmentObject private var viewModel: CalculatorView.ViewModel
    
    let historyItem: HistoryItem
    let cornerRadius: CGFloat = 16
    let cardHeight: CGFloat = 100
    var boxHeight: CGFloat {
        return cardHeight / 2.5
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

struct HistorySheetView: View {
    @EnvironmentObject private var viewModel: CalculatorView.ViewModel
    
    @State private var testHistoryItems: [HistoryItem] = [
        HistoryItem(action: "(10 * 2) / 2 =", result: "10"),
        HistoryItem(action: "10 * 2 =", result: "20"),
        HistoryItem(action: "15 * 3 =", result: "45"),
        HistoryItem(action: "8 * 4 =", result: "32"),
        HistoryItem(action: "12 * 7 =", result: "84")
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                Text("History Item Count: \(viewModel.historyItems.count)")
                List {
                    ForEach(viewModel.historyItems.reversed()) { item in
                        HistoryCardView(historyItem: item)
                            .listRowSeparator(.hidden)
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal)
                    }
                    .onDelete { indices in
                        viewModel.historyItems.remove(atOffsets: indices)
                        viewModel.saveHistoryItems()
                    }
                    .padding(.top)
                }
                .listStyle(PlainListStyle())
            }
            .navigationBarTitle("History")
            .navigationBarItems(trailing: clearButton)
        }
    }
}

extension HistoryCardView {
    
    private var expressionInRectangle: some View {
        Rectangle()
            .fill(Color("cardHeadlineColor"))
            .frame(maxWidth: .infinity, maxHeight: boxHeight)
            .overlay(
                Text(historyItem.action)
                    .font(.headline)
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

extension HistorySheetView {
    
    private var clearButton: some View {
        Button(action: {
            viewModel.historyItems.removeAll()
            viewModel.saveHistoryItems()
        }) {
            Text("Clear")
                .foregroundColor(.red) // Customize the color as needed
        }
    }
}

struct HistorySheetView_Previews: PreviewProvider {
    static var previews: some View {
        HistorySheetView()
            .environmentObject(CalculatorView.ViewModel())
    }
}
