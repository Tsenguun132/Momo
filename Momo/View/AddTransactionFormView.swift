//
//  AddTransactionFormView.swift
//  Momo
//
//  Created by Tsenguun on 4/8/22.
//

import SwiftUI

struct AddTransactionFormView: View {
    
    @Environment(\.managedObjectContext) var context
    @Environment(\.presentationMode) var presenatationMode: Binding<PresentationMode>
    
    @ObservedObject private var addTransactionFormViewModel: AddTransactionFormViewModel
    
    var payment: PaymentActivity?
    
    init(payment: PaymentActivity? = nil) {
        self.payment = payment
        self.addTransactionFormViewModel = AddTransactionFormViewModel(paymentActivity: payment)
    }
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    // action
                } label: {
                    Image(systemName: SFSymbols.backArrow) // or cancel
                        .font(.system(.title2, design: .default))
                }
                Spacer()
                Text("Add new...")
                    .font(.system(.title3))
                    .fontWeight(.semibold)
                Spacer()
                Button {
                    // action
                } label: {
                    Text("...")
                        .fontWeight(.heavy)
                        .font(.system(size: 40))
                        .offset(y: -10)
                }

            }
            .padding()
            .foregroundColor(.black)
            
            VStack {
                
                // to do choose income or expense
                
                VStack {
                    HStack(spacing: 0){
                        Button {
                            self.addTransactionFormViewModel.type = .income
                        } label: {
                            Text("Income")
                                .font(.headline)
                                .foregroundColor(self.addTransactionFormViewModel.type == .income ? Color.white : Color.primary)
                                .padding(.horizontal, 30)
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .background(self.addTransactionFormViewModel.type == .income ? Color("darkGreen") : Color.white)
                        .cornerRadius(10)

                        Button {
                            self.addTransactionFormViewModel.type = .expense
                        } label: {
                            Text("Expense")
                                .font(.headline)
                                .foregroundColor(self.addTransactionFormViewModel.type == .expense ? Color.white : Color.primary)
                                .padding(.horizontal, 30)
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .background(self.addTransactionFormViewModel.type == .expense ? Color("darkGreen") : Color.white)
                        .cornerRadius(10)
                    }
                    .overlay(content: {
                        RoundedRectangle(cornerRadius: 10)
                            .strokeBorder(Color.gray.opacity(0.5), lineWidth: 1.5)
                    })
                    .padding()
                } // vstack end
                
                FormTextField(name: "Name", placeHolder: "Enter here", value: $addTransactionFormViewModel.name)
                
                FormTextField(name: "Amount", placeHolder: "0.0", value: $addTransactionFormViewModel.amount)
                
                FormDateField(name: "Date", value: $addTransactionFormViewModel.date)
                
                Spacer()
                
                Button {
                    // save button
                } label: {
                    Text("Add new") // change to add new expense or income based on status
                        .font(.system(.title3, design: .default))
                        .bold()
                        .foregroundColor(.white)
                        .padding()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .background(Color("darkGreen"))
                        .cornerRadius(10)
                        .padding()
                }

            }
            .background(Color.white)
            .cornerRadius(20)
            .padding()
            
            Spacer()
        } //VStack end
        .background(Color.backgroundGrayColor)
    }
}

struct AddTransactionFormView_Previews: PreviewProvider {
    static var previews: some View {
        AddTransactionFormView().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}

struct FormTextField: View {
    
    var name: String
    var placeHolder: String
    
    @Binding var value: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(name.uppercased())
                .font(.system(.caption, design: .default))
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            TextField(placeHolder, text: $value)
                .font(.headline)
                .foregroundColor(.primary)
                .padding()
                .overlay(content: {
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(Color.gray.opacity(0.5), lineWidth: 1.5)
                })

        }
        .padding()
    }
}

struct FormDateField: View {
    
    let name: String
    @Binding var value: Date
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(name.uppercased())
                .font(.system(.caption, design: .default))
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            
            HStack {
                DatePicker("", selection: $value, displayedComponents: [.date])
//                    .tint(.primary)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    .padding(10)
                    .labelsHidden()
                    .accentColor(.gray)
                Image(systemName: "calendar")
                    .font(.system(.title))
                    .foregroundColor(.gray)
                    .padding(.trailing)
            }
            .overlay(content: {
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(Color.gray.opacity(0.5), lineWidth: 1.5)
            })
            
        }
        .padding()
    }
}
