//
//  ContentView.swift
//  WeSplit
//
//  Created by Reza Enayati on 8/8/24.
//

// We need the cost of the check, the number of people it is being splitted by and the tip percentage.
import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    
    var totalWithTip:Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let total = checkAmount + tipValue
        return total
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let amountPerPerson = totalWithTip / peopleCount
        return amountPerPerson
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(2..<50) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section("How Much do you want to tip?") {
                    
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(0..<101) {
                            if $0%5 == 0 {
                                Text($0, format: .percent)
                            }
                        }
                    }
                    .pickerStyle(NavigationLinkPickerStyle())
                }
                Section("Total Amount of Check with Tip") {
                    Text(totalWithTip, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    
                }
                
                Section("Amount Per Person") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}
#Preview {
    ContentView()
}

