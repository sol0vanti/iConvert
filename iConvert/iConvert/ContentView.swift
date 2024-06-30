//
//  ContentView.swift
//  iConvert
//
//  Created by Alex Balla on 30.06.2024.
//

import SwiftUI

struct ContentView: View {
    @State var unitToConvert = "Length"
    @State var inputUnit = "meters"
    @State var outputUnit = "kilometers"
    @State var inputValue = 0
    
    var outputValue: String {
        let value = Double(inputValue)
        var kilometers: Measurement<UnitLength> = .init(value: 0, unit: .kilometers)
        
        // Length
        if inputUnit == "meters" || outputUnit == "kilometers" {
            let meters = Measurement(value: value, unit: UnitLength.meters)
            kilometers = meters.converted(to: .kilometers)
        }
        let formatter = MeasurementFormatter()
        return formatter.string(from: kilometers)
    }
    
    let valuesToConvert = ["Temperature": ["Celsius", "Fahrenheit", "Kelvin"], "Length": ["meters", "kilometers", "feet", "yards", "miles"], "Time": ["seconds", "minutes", "hours", "days"], "Volume": ["liters", "gallons", "cubic meters"]]
    
    var body: some View {
        let units = valuesToConvert[unitToConvert]
        NavigationStack {
            Form {
                Picker("Unit to convert", selection: $unitToConvert) {
                    ForEach(Array(valuesToConvert.keys).sorted(), id:\.self) {
                        Text($0)
                    }
                }
                
                Section("Input values") {
                    TextField("Value", value: $inputValue, format: .number)
                    
                    Picker("Unit", selection: $inputUnit) {
                        ForEach(units!, id: \.self) { unit in
                            Text(unit)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Output values") {
                    Text("\(outputValue)")
                    
                    Picker("Unit", selection: $outputUnit) {
                        ForEach(units!, id: \.self) { unit in
                            Text(unit)
                        }
                    }
                    .pickerStyle(.segmented)
                }
            }
            .navigationTitle("iConvert")
        }
    }
}

#Preview {
    ContentView()
}
