//
//  calcView.swift
//  saver
//
//  Created by Daven Hill on 2/17/23.
//

import SwiftUI

struct calcView: View {
    @State private var amount = 0.0
    @State private var percentage = 0.0

   
    var body: some View {
        let saveAmount = (amount * percentage)
        Form{
            Section(header: Text("Enter the amount of your paycheck:")){
                TextField("Amount", value: $amount, format: .currency(code: "USD"))
                    .keyboardType(.decimalPad)
            }
            Section(header: Text("Enter in the percent you wish to save")) {
                TextField("Amount", value: $percentage, format: .currency(code: "USD"))
                    .keyboardType(.numberPad)
               }
            
            Section(header: Text("You should be saving this much:")){
                Text(saveAmount, format: .currency(code: "USD"))

            }
        }
    }
}

struct calcView_Previews: PreviewProvider {
    static var previews: some View {
        calcView()
    }
}
