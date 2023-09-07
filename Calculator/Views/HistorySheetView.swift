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

    var body: some View {
        NavigationView {
            VStack {
                Text("History Item Count: \(viewModel.historyItems.count)")
                historyCardsList
            }
            .navigationBarTitle("History")
            .navigationBarItems(trailing: clearButton)
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
    
    private var historyCardsList: some View {
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

struct HistorySheetView_Previews: PreviewProvider {
    static var previews: some View {
        HistorySheetView()
            .environmentObject(CalculatorView.ViewModel())
    }
}
