//
//  HistoryView.swift
//  Calculator
//
//  Created by Yegor Myropoltsev on 05.09.2023.
//

import SwiftUI

struct HistoryView: View {
    @EnvironmentObject private var viewModel: CalculatorView.ViewModel
    @State private var isClearAlertPresented = false
    
    private var itemsCount: Int {
        viewModel.historyItems.count
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if itemsCount == 0 {
                    emptyText
                } else {
                    historyCardsList
                }
            }
            .navigationBarTitle("History")
            .navigationBarItems(trailing: clearButton)
            .frame(maxWidth: .infinity)
        }
    }
}

extension HistoryView {
    
    private var emptyText: some View {
        Text("Empty")
            .foregroundColor(Color("highlightColor"))
            .font(.system(size: 36, weight: .ultraLight))
            .transition(.opacity)
            .padding(.bottom, 50)
    }
    
    private var clearButton: some View {
        Button(action: {
            isClearAlertPresented.toggle()
        }) {
            Text("Clear")
                .foregroundColor(.red)
        }
        .alert(isPresented: $isClearAlertPresented) {
            Alert(
                title: Text("Clear History"),
                message: Text("Do you want to clear all items?"),
                primaryButton: .destructive(Text("Clear")) {
                    withAnimation(.easeOut(duration: 0.25)) {
                        viewModel.historyItems.removeAll()
                        viewModel.saveHistoryItems()
                    }

                },
                secondaryButton: .cancel()
            )
        }
    }
    
    private var historyCardsList: some View {
        List {
            ForEach(viewModel.historyItems) { item in
                HistoryCardStyle(historyItem: item)
                    .listRowSeparator(.hidden)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
            }
            .onDelete { index in
                viewModel.deleteHistoryItems(at: index)
                viewModel.saveHistoryItems()
            }
            .padding(.top)
        }
        .listStyle(PlainListStyle())
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
            .environmentObject(CalculatorView.ViewModel())
    }
}
