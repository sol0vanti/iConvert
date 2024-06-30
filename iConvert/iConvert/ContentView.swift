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
    @State var outputUnit = "meters"
    @State var inputValue = 0
    
    var outputValue: String {
        let value = Double(inputValue)
        let valueDictLength: [String: UnitLength] = [
            "meters": .meters,
            "kilometers": .kilometers,
            "feet": .feet,
            "yards": .yards,
            "miles": .miles
        ]
                
        let valueDictTemp: [String: UnitTemperature] = [
            "Celsius": .celsius,
            "Fahrenheit": .fahrenheit,
            "Kelvin": .kelvin
        ]
                
        let valueDictTime: [String: UnitDuration] = [
            "seconds": .seconds,
            "minutes": .minutes,
            "hours": .hours
        ]
                
        switch unitToConvert {
        case "Length":
            if let fromUnit = valueDictLength[inputUnit],
                let toUnit = valueDictLength[outputUnit] {
                let valueFrom = Measurement(value: value, unit: fromUnit)
                let valueTo = valueFrom.converted(to: toUnit)
                let formatter = MeasurementFormatter()
                return formatter.string(from: valueTo)
            }
        case "Temperature":
            if let fromUnit = valueDictTemp[inputUnit],
               let toUnit = valueDictTemp[outputUnit] {
                let valueFrom = Measurement(value: value, unit: fromUnit)
                let valueTo = valueFrom.converted(to: toUnit)
                let formatter = MeasurementFormatter()
                return formatter.string(from: valueTo)
            }
        case "Time":
            if let fromUnit = valueDictTime[inputUnit],
               let toUnit = valueDictTime[outputUnit] {
                let valueFrom = Measurement(value: value, unit: fromUnit)
                let valueTo = valueFrom.converted(to: toUnit)
                let formatter = MeasurementFormatter()
                return formatter.string(from: valueTo)
            }
        default:
            return "Error"
        }
                
        return "Error"
    }
    
    let valuesToConvert = ["Temperature": ["Celsius", "Fahrenheit", "Kelvin"], "Length": ["meters", "kilometers", "feet", "yards", "miles"], "Time": ["seconds", "minutes", "hours", "days"]]
    
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
