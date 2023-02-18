//
//  ContentView.swift
//  saver
//
//  Created by Daven Hill on 10/8/22.
//
import SwiftUI
import Charts

struct transaction: Identifiable {
    var type: String
    var amount: Double
    var id = UUID()
}

let data: [transaction] = [
    .init(type: "Deposit", amount: 500),
    .init(type: "Withdraw", amount: 600)
]


struct TrailingButtonStyle: ButtonStyle{
    func makeBody(configuration: Configuration) -> some View {
        HStack{
            Spacer()
            configuration.label
                .padding()
                .background(Color(red: 0, green: 0, blue: 0.5))
                .clipShape(Capsule())
                .font(.system(.headline,design: .serif))
                .foregroundColor(.white)
                .padding()
        }
    }
}


struct ContentView: View {
    
    @State private var savingButtonClicked = false
    
    @FocusState private var keyboardPrompt: Bool
    
    @State private var showDepAmtTextField: Bool = false
    @State private var showWithdrawAmtTextField: Bool = false
    
    @AppStorage("amount") private var balance: Double = 0.0
    @State private var deposits : Double = 0.0
    
    var expenses = ["Food", "Travel", "Clothing", "Technology", "Utilities"];
    @State private var selectedExpense = "Food"
    @State private var inputAmount: Double = 0.0
    
    func deposit(dep: Double){
        balance += dep
    }
    func withdraw(withdrawAmt: Double){
        balance -= withdrawAmt
    }
    // Formats number to a decimal
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }()
    
    var keyboardType: UIKeyboardType = .decimalPad
    
    
    
    var body: some View {
        
        VStack {
            Section{
                Text(balance, format: .currency(code: "USD")).font(.system(size:55,design: .serif))
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color(red: 0, green: 0, blue:0.5),lineWidth: 2))
                Text("Balance").font(.system(size:25, design:.serif))
            }//end of section
            
            
            //Chart Section
            Section{
                Chart(data, id: \.id){ item in
                    BarMark(
                        x: .value("Type", item.type),
                        y: .value("Amount", item.amount)
                        
                    )
                    
                }//end of chart
                
                
            }//end of section
            
            Grid(alignment: .leading){
                
                Divider()
                    .frame(height: 2)
                    .overlay(.black
                    )
                GridRow{
                    
                    Text("Deposit Money")
                        .font(.system(.headline,design: .serif))
                    Button("Deposit"){
                        
                        keyboardPrompt = true
                        
                        if showDepAmtTextField{
                            deposit(dep: inputAmount)
                            
                        }
                        showDepAmtTextField.toggle()
                        
                        
                    }//end of button
                    
                }
                GridRow{
                    if (showDepAmtTextField){
                        TextField("Amount: ", value: $inputAmount, formatter: formatter).focused($keyboardPrompt).keyboardType( .decimalPad).onSubmit {
                            deposit(dep: inputAmount)
                            
                        }
                        
                    }
                }//end of gridrow
                Divider()
                    .frame(height:2)
                    .overlay(.black)
                
                GridRow{
                    
                    Text("Withdraw Money").font(.system(.headline,design: .serif))
                    
                    Button("Withdraw"){
                        
                        keyboardPrompt = true
                        if showWithdrawAmtTextField{
                            withdraw(withdrawAmt: inputAmount)
                            
                        }
                        showWithdrawAmtTextField.toggle()
                    }//end of button
                    
                    
                }//end of gridrow
                
                GridRow{
                    if (showWithdrawAmtTextField){
                        TextField("Amount: ", value: $inputAmount, formatter: formatter).focused($keyboardPrompt).keyboardType( .decimalPad).onSubmit {
                            withdraw(withdrawAmt: inputAmount)
                            
                        }//end of textfield
                        
                    }//end of if
                }
                Divider()
                    .frame(height:2)
                    .overlay(.black)
                GridRow{
                    Text("Saving Goal Calculator").font(.system(.headline,design: .serif))
                    Button("Go there"){
                        savingButtonClicked.toggle()
                    }
                    .sheet(isPresented: $savingButtonClicked){
                        calcView()
                    }
                    
                    
                }//end of grid row
            }
            // end of grid
            .padding(10)
            .buttonStyle(TrailingButtonStyle())
            
        }
        //end of body
    }
    //end of contentview
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

