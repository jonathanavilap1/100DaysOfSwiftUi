//
//  ContentView.swift
//  weSplit
//
//  Created by Jonathan Avila on 05/08/23.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    var currencyFormatter: FloatingPointFormatStyle<Double>.Currency {
        FloatingPointFormatStyle<Double>.Currency(code: Locale.current.currency?.identifier ?? "USD")
    }
    
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalAmount : Double {
        return TiptotalPerPerson * Double(numberOfPeople)
    }
    
    var TiptotalPerPerson: Double {
        let peopleCount = Double(numberOfPeople)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var TipPerPerson: Double {
        let peopleCount = Double(numberOfPeople)
        let tipSelection = Double(tipPercentage)
        
        return (checkAmount / 100 * tipSelection)/peopleCount
    }
    
    var body: some View {
        
        NavigationStack{
            
            Form {
                Section {
                    TextField("Select check amount", value: $checkAmount, format: currencyFormatter)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                }
                
                Section {
                    Picker("Number of people", selection: $numberOfPeople){
                        ForEach(2..<10){
                            Text("\($0) people").tag($0)
                        }
                    }
                }
                
                Section {
                    Picker("Select a tip", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self){
                            Text($0, format: .percent)
                        }
                    }.pickerStyle(.segmented)
                }header: {
                    Text("How much do you want to leave")
                }
// This screen is a challengue from hacking with swift and it syncs with the picker
//                Section {
//                    Picker("Select a tip ", selection: $tipPercentage) {
//                        ForEach(0..<101){
//                            Text($0, format: .percent).tag($0)
//                        }
//                    }.pickerStyle(.navigationLink)
//                }header: {
//                    Text("Tip new screen")
//                }
                
                Section {
                    Text(TiptotalPerPerson, format: currencyFormatter)
                }header: {
                    Text("Amount Per Person")
                }
                
                Section{
                    Text(TipPerPerson, format: currencyFormatter)
                }header: {
                    Text("Tip per person")
                }
                
                Section{
                    Text(totalAmount, format: currencyFormatter)
                }header: {
                    Text("Grand total")
                }
                
            } .navigationTitle("We split")
                .toolbar{
                    ToolbarItemGroup(placement: .keyboard){
                        Spacer()
                        Button("Done"){
                            amountIsFocused = false
                        }
                    }
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
