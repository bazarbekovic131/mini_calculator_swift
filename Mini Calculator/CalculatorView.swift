//
//  ContentView.swift
//  Mini Calculator
//
//  Created by Akha on 06.10.2024.
//

import SwiftUI

struct CalculatorView: View {
    @State private var display = "0"
    @State private var currentNumber = ""
    @State private var previousNumber = ""
    @State private var operation: CalculatorOperation?
    @State private var isTypingNumber = false
    @Binding var showSecretView: Bool

    let buttons: [[CalculatorButton]] = [
        [.utility("C"), .utility("±"), .utility("%"), .operation("÷")],
        [.number("7"), .number("8"), .number("9"), .operation("×")],
        [.number("4"), .number("5"), .number("6"), .operation("−")],
        [.number("1"), .number("2"), .number("3"), .operation("+")],
        [.number("0"), .number("."), .operation("=")]
    ]

    var body: some View {
        VStack {
            Spacer()
            Text(display)
                .font(.largeTitle)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding()

            ForEach(buttons, id: \.self) { row in
                HStack {
                    ForEach(row, id: \.self) { button in
                        Button(action: {
                            self.tapButton(button)
                        }) {
                            Text(button.title)
                                .modifier(CalculatorButtonStyle())
                        }
                    }
                }
            }
        }
        .padding()
    }

    func tapButton(_ button: CalculatorButton) {
        switch button {
        case .number(let value):
            tapNumber(value)
        case .operation(let symbol):
            if symbol == "=" {
                tapEqual()
            } else {
                tapOperation(symbol)
            }
        case .utility(let function):
            tapUtility(function)
        }
    }

    func tapNumber(_ number: String) {
        if isTypingNumber {
            currentNumber += number
        } else {
            currentNumber = number
            isTypingNumber = true
        }
        display = currentNumber
    }

    func tapOperation(_ symbol: String) {
        if isTypingNumber {
            calculateResult()
            isTypingNumber = false
        }
        previousNumber = currentNumber
        currentNumber = ""
        operation = CalculatorOperation(symbol: symbol)
    }

    func tapEqual() {
        if currentNumber == "667667" {
            // Trigger navigation to the secret screen
            showSecretView = true
            print("it worked")
            clear()
        } else {
            calculateResult()
            isTypingNumber = false
            operation = nil
        }
    }

    func tapUtility(_ function: String) {
        switch function {
        case "C":
            clear()
        case "±":
            toggleSign()
        case "%":
            applyPercentage()
        default:
            break
        }
    }

    func calculateResult() {
        guard let operation = operation,
              let prevValue = Double(previousNumber),
              let currValue = Double(currentNumber) else {
            return
        }

        var result: Double = 0

        switch operation {
        case .addition:
            result = prevValue + currValue
        case .subtraction:
            result = prevValue - currValue
        case .multiplication:
            result = prevValue * currValue
        case .division:
            result = prevValue / currValue
        }

        currentNumber = String(result)
        display = currentNumber
        previousNumber = currentNumber
    }

    func clear() {
        currentNumber = ""
        previousNumber = ""
        operation = nil
        isTypingNumber = false
        display = "0"
    }

    func toggleSign() {
        if let value = Double(currentNumber) {
            currentNumber = String(-value)
            display = currentNumber
        }
    }

    func applyPercentage() {
        if let value = Double(currentNumber) {
            currentNumber = String(value / 100)
            display = currentNumber
        }
    }
}

enum CalculatorOperation {
    case addition, subtraction, multiplication, division

    init?(symbol: String) {
        switch symbol {
        case "+":
            self = .addition
        case "−":
            self = .subtraction
        case "×":
            self = .multiplication
        case "÷":
            self = .division
        default:
            return nil
        }
    }
}

enum CalculatorButton: Hashable {
    case number(String)
    case operation(String)
    case utility(String)

    var title: String {
        switch self {
        case .number(let value), .operation(let value), .utility(let value):
            return value
        }
    }
}

struct CalculatorButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title)
            .frame(width: 80, height: 80)
            .background(Color.orange.opacity(0.9))
            .cornerRadius(40)
            .foregroundColor(.white)
    }
}

#Preview {
    CalculatorView(showSecretView: .constant(false))
        .background(Color.white)
}
