//
//  ContentView.swift
//  UnitConvertion
//
//  Created by Jonathan Avila on 09/09/23.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedOutput = UnitDuration.seconds
    @State private var selectedInput = UnitDuration.seconds
    @State private var unitTextField = "0"
    @State var resultString = "Waiting for convertion"
    
    @FocusState private var amountIsFocused: Bool
    let unitOfMeasure: [UnitDuration] = [.seconds, .minutes, .hours, .days]
    
    func convertion(){
        guard let inputValue = Double(unitTextField) else { return }
        let inputMeasure = Measurement(value: inputValue, unit: selectedInput)
        let outputMeasure = inputMeasure.converted(to: selectedOutput)
        resultString = "\(outputMeasure.value.formatted()) \(unitString(from: selectedOutput))"
    }
    
    func unitString(from unit: UnitDuration) -> String {
        switch unit {
        case .seconds: return "seconds"
        case .minutes: return "minutes"
        case .hours: return "hours"
        case .days: return "days"
        default: return unit.symbol
        }
    }
    
    var body: some View {
        
        NavigationStack{
            Form {
                Section{
                        VStack{
                            Text("Please select the input")
                                .bold()
                                .foregroundColor(.blue)
                            
                            Picker("Select an unit of measurement", selection: $selectedInput){
                                ForEach(unitOfMeasure, id: \.self){ unit in
                                    Text(unitString(from: unit)).tag(unit)
                                }
                            }.pickerStyle(.segmented)
                        }
                    
                        VStack{
                            Text("Please type the amount")
                                .bold()
                                .foregroundColor(.blue)
                            
                            TextField("Type the unit", text: $unitTextField)
                                .keyboardType(.decimalPad)
                                .focused($amountIsFocused)
                                .multilineTextAlignment(.center)
                        }
                    
                        VStack{
                            Text("Please select the output")
                                .bold()
                                .foregroundColor(.blue)
                            
                            Picker("Select an unit of measurement", selection: $selectedOutput){
                                ForEach(unitOfMeasure.filter{$0 != selectedInput}, id: \.self){ unit in
                                    Text(unitString(from: unit)).tag(unit)
                                }
                            }.pickerStyle(.segmented)
                        }
                }.alignmentGuide(.listRowSeparatorLeading) { viewDimensions in
                    return -20
                }
                
                Section{
                    Button("Convert"){
                        convertion()
                    }
                }
                
                Section{
                    Text(resultString)
                }header: {
                    Text("Result")
                }
            }.navigationTitle("Unit Converter")
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

extension UnitDuration{
    static let days = UnitDuration(symbol: "days", converter: UnitConverterLinear(coefficient: 86400))
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
