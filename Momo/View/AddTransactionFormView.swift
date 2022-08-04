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
                    Image(systemName: SFSymbols.backArrow)
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
                
                FormTextField(name: "Name", placeHolder: "Enter here", value: $addTransactionFormViewModel.name)
                
                FormTextField(name: "Amount", placeHolder: "0.0", value: $addTransactionFormViewModel.amount)
                
                FormDateField(name: "Date", value: $addTransactionFormViewModel.date)
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
