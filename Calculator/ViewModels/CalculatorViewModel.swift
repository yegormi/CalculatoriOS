//
//  CalculatorViewModel.swift
//  Calculator
//
//  Created by Yegor Myropoltsev on 28.08.2023.
//

import SwiftUI

extension CalculatorView {
    
    final class ViewModel: ObservableObject {
        
        // MARK: - PROPERTIES
        
        @Published private var calculator = Calculator()
        @Published var historyItems: [HistoryItem] = []
        
        private let historyItemsKey = "historyItems"

        var displayText: String {
            return calculator.displayText
        }
        
        var buttonTypes: [[ButtonType]] {
            let clearType: ButtonType = calculator.showAllClear ? .allClear : .clear
            return [
                [clearType, .negative, .percent, .operation(.division)],
                [.digit(.seven), .digit(.eight), .digit(.nine), .operation(.multiplication)],
                [.digit(.four), .digit(.five), .digit(.six), .operation(.subtraction)],
                [.digit(.one), .digit(.two), .digit(.three), .operation(.addition)],
                [.digit(.zero), .decimal, .equals]
            ]
        }
        
        init() {
            if let storedHistoryItemsData = UserDefaults.standard.data(forKey: historyItemsKey),
               let loadedHistoryItems = try? JSONDecoder().decode([HistoryItem].self, from: storedHistoryItemsData) {
                historyItems = loadedHistoryItems
            }
        }
        
        // MARK: - ACTIONS
        
        func performAction(for buttonType: ButtonType) {
            switch buttonType {
            case .digit(let digit):
                calculator.setDigit(digit)
            case .operation(let operation):
                calculator.setOperation(operation)
            case .negative:
                calculator.toggleSign()
            case .percent:
                calculator.setPercent()
            case .decimal:
                calculator.setDecimal()
            case .equals:
                calculator.evaluate()
                appendHistoryItem()
            case .allClear:
                calculator.allClear()
            case .clear:
                calculator.clear()
            }
        }
        
        // MARK: - HELPERS
        
        func deleteHistoryItems(at offsets: IndexSet) {
            historyItems.remove(atOffsets: offsets)
        }
        
        func saveHistoryItems() {
            if let encodedData = try? JSONEncoder().encode(historyItems) {
                UserDefaults.standard.set(encodedData, forKey: historyItemsKey)
            }
        }
        
        func appendHistoryItem() {
            guard calculator.isEvaluationPerformed() else { return }
            if let historyItem = createHistoryItem() {
                historyItems.insert(historyItem, at: 0)
                saveHistoryItems()
            }
            calculator.setEvaluated(to: false)
        }
        
        func getExpressionText() -> String? {
            if let expression = calculator.expressionText {
                return "\(expression)"
            }
            return nil
        }
        
        func getResultText() -> String? {
            if let result = calculator.resultText {
                return "\(result)"
            }
            return nil
        }
        
        func createHistoryItem() -> HistoryItem? {
            guard let expression = calculator.getCurrentExpressionText(), let result = calculator.getCurrentResultText() else {
                return nil
            }
            return HistoryItem(action: expression, result: result)
        }
        
        func buttonTypeIsHighlighted(buttonType: ButtonType) -> Bool {
            guard case .operation(let operation) = buttonType else { return false }
            return calculator.operationIsHighlighted(operation)
        }
    }
}
