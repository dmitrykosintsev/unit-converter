//
//  ContentView.swift
//  ConverIt
//
//  Created by Dmitrii Kosintsev on 2023.08.25.
//

import SwiftUI

struct ContentView: View {
    
    let conversionTypes = ["temperature", "length", "time", "volume"]
    let units = (temperature: ["Celsius", "Fahrenheit", "Kelvin"], length: ["m", "km", "ft", "yd", "mi"], time: ["sec", "min", "hr", "days"], volume: ["ml", "l", "c.", "pt", "gal"])
    @State var conversionType: String = "temperature"
    @State var inputNum: Double = 0.0
    @State var inputUnit: String = "km"
    @State var outputUnit: String = "m"
    
    //returns an array with possible units for the chosen conversion
    var currentUnits: [String] {
        let currUnits: [String]
        switch conversionType {
        case "volume":
            currUnits = units.volume
        case "length":
            currUnits = units.length
        case "time":
            currUnits = units.time
        default:
            currUnits = units.temperature
        }
        
        return currUnits
    }
    
    var outputNum: Double {
        if (inputUnit == "Celsius" && outputUnit == "Fahrenheit") {
            return (9/5)*inputNum + 32
        }
        if (inputUnit == "Celsius" && outputUnit == "Kelvin") {
            return inputNum + 273.15
        }
        if (inputUnit == "Kelvin" && outputUnit == "Celsius") {
            return inputNum - 273.15
        }
        if (inputUnit == "Kelvin" && outputUnit == "Fahrenheit") {
            return (inputNum - 273.15) * 9 / 5 + 32
        }
        if (inputUnit == "Fahrenheit" && outputUnit == "Kelvin") {
            return (inputNum - 32) * 5 / 9 + 273.15
        }
        if (inputUnit == "Fahrenheit" && outputUnit == "Celsius") {
            return (inputNum - 32) * 5 / 9
        } else {
            return 0.0
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                //choose what to convert
                Picker("What to convert", selection: $conversionType) {
                    ForEach(conversionTypes, id: \.self) {
                        Text($0)
                    }
                }
                
                //enter the value
                TextField("Enter the value", value: $inputNum, format: .number)
                
                //choose the input unit
                Picker("Input units", selection: $inputUnit) {
                    ForEach(currentUnits, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.segmented)
                
                //choose the output unit
                Picker("Output units", selection: $outputUnit) {
                    ForEach(currentUnits, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.segmented)
                
                //display the result of conversion
                Text("\(outputNum, specifier: "%.2f")")
            }
            .navigationTitle("ConvertIt")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
