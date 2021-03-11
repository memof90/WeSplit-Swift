//
//  ContentView.swift
//  WeSplit
//
//  Created by Memo Figueredo on 11/1/19.
//  Copyright © 2019 DeTodoUnPoquito. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
//    init() {
//        //Use this if NavigationBarTitle is with Large Font
////        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(red:0.10, green:0.74, blue:0.61, alpha:1.0)]
////        UINavigationBar.appearance().backgroundColor = UIColor(red:0.10, green:0.74, blue:0.61, alpha:1.0)
//
//        //Use this if NavigationBarTitle is with displayMode = .inline
////        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(red:0.17, green:0.24, blue:0.31, alpha:1.0)]
////        UINavigationBar.appearance().backgroundColor = UIColor.init(displayP3Red: 0.0, green: 0.74, blue: 0.61, alpha: 1.0)
//    }
    struct NavigationConfigurator: UIViewControllerRepresentable {
        var configure: (UINavigationController) -> Void = { _ in }

        func makeUIViewController(context: UIViewControllerRepresentableContext<NavigationConfigurator>) -> UIViewController {
            UIViewController()
        }
        func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<NavigationConfigurator>) {
            if let nc = uiViewController.navigationController {
                self.configure(nc)
            }
        }

    }
    
//    Proporcione al usuario la entrada de TextField por defecto de 1, y establezca los SegmentedPickers en la selección central
    @State private var inputVar = "1"
    @State private var inputUnit = 3
    @State private var outputunit = 3
    
//    Un array define las opciones segmentedPicker
     var lengthUnits = ["mm", "cm", "m", "km", "Pulg", "pie", "yard", "mile"]
//    La propiedad calculada a continuación convierte la cantidad de entrada y la unidad a mm y luego a la unidad de conversión deseada
     
    var conversion: Double {
        
        //empezar unidad
        let unidadInicio = lengthUnits[inputUnit]
        var factorInicio: Double = 1
        
        //Terminar Unidad
        let UnidadFinal = lengthUnits[outputunit]
        var factorFinal: Double = 1
        
        switch unidadInicio {
        case "cm":
            factorInicio = 10
        case "m":
            factorInicio = 1000
        case "km":
            factorInicio = 1000000
        case "Pulg":
            factorInicio = 25.4
        case "pie":
            factorInicio = 25.4 * 12
        case "yard":
            factorInicio = 25.4 * 12 * 3
        case "mile":
            factorInicio = 25.4 * 12 * 5280
        default:
            factorInicio = 1
        }
        
       let mmConversion = factorInicio * Double(Double(inputVar) ?? 0)
        
        switch UnidadFinal {
        case "cm":
            factorFinal = 1/10
        case "m":
            factorFinal = 1/1000
        case "km":
            factorFinal = 1/1000000
        case "Pulg":
            factorFinal = 1/25.4
        case "pie":
            factorFinal = 1 / (25.4 * 12)
        case "yard":
            factorFinal = 1 / (25.4 * 12 * 3)
        case "mile":
            factorFinal = 1 / (25.4 * 12 * 5280)
            
        default:
            factorFinal = 1
        }
        
        let conversionDeseada =  mmConversion * factorFinal
        
        return conversionDeseada
    }
    
  
    
    
    
    var body: some View {
        
        NavigationView {
            Form {
                Section(header: Text("Unidades a Covertir").padding()) {
                    Picker("Lenght Units", selection: $inputUnit){
                  ForEach(0..<lengthUnits.count){
                    Text("\(self.lengthUnits[$0])")
                        }
                     }.pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Numero de Unidades a convertir")){
                    TextField("Numero a convertir de Unidades a convertir", text: $inputVar)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("Unidades para convertir a")){
                    Picker("Lenght Units",selection: $outputunit){
                        ForEach(0..<lengthUnits.count){
                            Text("\(self.lengthUnits[$0])")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                

//                El especificador de formato permite la conversión de unidades pequeñas a unidades muy grandes (por ejemplo, mm a millas)
                Section(header: Text("El Resultado es:")){
                    Text("\(self.conversion, specifier: "%.9f")")
                }
                
            }.navigationBarTitle("App Conversiones ", displayMode:.inline).navigationBarHidden(false)
                .background(NavigationConfigurator { nc in
                    nc.navigationBar.barTintColor = .init(displayP3Red: 0.10, green: 0.74, blue: 0.61, alpha: 1.0)
                    nc.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.white]
                })
                .navigationViewStyle(StackNavigationViewStyle())
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
