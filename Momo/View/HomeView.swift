//
//  HomeView.swift
//  Momo
//
//  Created by Tsenguun on 2/8/22.
//

import SwiftUI
import CoreData

struct HomeView: View {
//
    @Environment(\.managedObjectContext) var context
//
    @FetchRequest(
        entity: PaymentActivity.entity(),
        sortDescriptors: [ NSSortDescriptor(keyPath: \PaymentActivity.date, ascending: false) ])
    var paymentActivities: FetchedResults<PaymentActivity>
//
//
    @FetchRequest var request: FetchedResults<PaymentActivity>
    
    init() {
        let request: NSFetchRequest<PaymentActivity> = PaymentActivity.fetchRequest() as! NSFetchRequest<PaymentActivity>
//        request.predicate = NSPredicate(format: "active = true")

        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \PaymentActivity.date, ascending: false)
        ]

        request.fetchLimit = 5
        request.fetchOffset = 5
        _request = FetchRequest(fetchRequest: request)
    }
    var body: some View {
        VStack {
            HeaderView()
            CardView()
            TransactionsView()
            List {
            ForEach(request, id: \.paymentID) { paymentActivity in
                    TransactionCellView(transaction: paymentActivity)
                        .listRowSeparator(.hidden)
                        .padding(.horizontal)
                }
                .onDelete(perform: deleteTask)
            }
            Spacer()
        }
        .background(Color.backgroundGrayColor)
    }
    
    private func delete(payment: PaymentActivity) {
        self.context.delete(payment)
        do {
            try self.context.save()
        } catch {
            print("Failed to save the context: \(error.localizedDescription)")
        }
    }
    private func deleteTask(indexSet: IndexSet) {
        for index in indexSet {
            let itemToDelete = paymentActivities[index]
            context.delete(itemToDelete)
        }
        DispatchQueue.main.async {
            do {
                try context.save()
            } catch {
                print(error)
            }
        }
    }

}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
//
        let context = PersistenceController.shared.container.viewContext
        let testTrans = PaymentActivity(context: context)
        testTrans.paymentID = UUID()
        testTrans.name = "Movie ticket"
        testTrans.amount = 200.0
        testTrans.date = .today
        testTrans.type = .expense

        
        return Group {
            HomeView()
            CardView().previewLayout(.sizeThatFits)
            TransactionCellView(transaction: testTrans).previewLayout(.sizeThatFits)
        }
    }
}

// Header / Title View
struct HeaderView: View {
    
    
    var body: some View {
            HStack {
                VStack(alignment: .leading) {
                    Text("Good afternoon,")
                        .font(.system(.subheadline, design: .default))
                    
                    Text("Tsenguun")
                        .font(.system(.title2))
                        .fontWeight(.semibold)
                }
                Spacer()
                
                Image(systemName: "bell")
                    .font(.title)
    //                .foregroundColor(.white)
            }
            .padding()
    }
}

// Card View
struct CardView: View {
        
    var body: some View {
        Rectangle()
            .frame(height: 200)
            .foregroundColor(Color("darkGreen"))
            .overlay {
                VStack {
                    HStack {
                        BalanceView(typeOf: "Total Balance ^", balance: 2548.00)
                        
                        Spacer()
                        
                        Text("...")
                            .foregroundColor(.white)
                            .fontWeight(.heavy)
                            .font(.system(size: 40))
                            .padding()
                            .offset(y: -30)
                    }
                    Spacer()
                    HStack {
                        MoneyTypeView(typeOf: "Income", balance: 1840.00, typeOfImage: SFSymbols.arrowDown)
                        Spacer()
                        MoneyTypeView(typeOf: "Expense", balance: 284.00, typeOfImage: SFSymbols.arrowUp)
                    }
                }
                .padding()
            }
            .cornerRadius(20)
            .padding()
            .shadow(color: Color("darkGreen").opacity(0.5), radius: 5, x: 0, y: 8)
            .padding(.bottom, 20)
    }
}

// Total Balance
struct BalanceView: View {
    
    let typeOf: String
    let balance: Double
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(typeOf)
                .font(.system(.title3))
                .fontWeight(.semibold)
            Text(NumberFormatter.currency(from: balance))
                .font(.system(.largeTitle))
                .fontWeight(.bold)
        }
        .foregroundColor(.white)
        
    }
}

// Income and Expense View
struct MoneyTypeView: View {
    
    let typeOf: String
    let balance: Double
    let typeOfImage: String
    
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                if typeOfImage != "" {
                    Image(systemName: typeOfImage)
                        .font(.body)
                        .padding(7)
                        .background(.gray.opacity(0.5))
                        .clipShape(Circle())

                }
                Text(typeOf)
                    .font(.system(.title3))
                    .fontWeight(.regular)
                    .opacity(0.8)
            }
            Text(NumberFormatter.currency(from: balance))
                .font(.system(.title2))
                .fontWeight(.bold)
        }
        .foregroundColor(.white)
        
    }
}

// Transactions View
struct TransactionsView: View {
    
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        VStack {
            HStack {
                Text("Transactions History")
                    .font(.system(.headline, design: .default))
                    .fontWeight(.semibold)
                Spacer()
                Button {
                    // action to do
                } label: {
                    Text("See all")
                        .font(.subheadline)
                        .foregroundColor(.black)
                        .opacity(0.6)
                }
            }
//            List {
//
//            }
        }
        .padding(.horizontal)
    }
}

struct TransactionCellView: View {
    
    @ObservedObject var transaction: PaymentActivity
    
    var body: some View {
        HStack {
            if transaction.isFault {
//                EmptyView()
                Text("Faulty")
            } else {
                Image(systemName: transaction.type == .income ? SFSymbols.arrowUp : SFSymbols.arrowDown)
                    .font(.title)
                    .padding(5)
                    .background(Color.gray.opacity(0.6))
                    .clipShape(Circle())

//                    .foregroundColor(Color(transaction.type == .income ? "IncomeCard" : " ExpenseCard")) // to add .opacity(0.5) // causing error
            // MARK: causing error
                
                VStack(alignment: .leading) {
                    Text(transaction.name)
                        .font(.system(.body, design: .default))
                    Text(transaction.date.string()) // causing crash
                        .font(.system(.caption, design: .default))
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                Text((transaction.type == .income ? "+" : "-") + NumberFormatter.currency(from: transaction.amount))
                    .font(.system(.title2,design: .default))
            }
        }
        .padding(.horizontal, 5)
    }
}
