//
//  AddTransactionViewModel.swift
//  Momo
//
//  Created by Tsenguun on 4/8/22.
//

import Foundation
import Combine

class AddTransactionFormViewModel: ObservableObject {
    
    //input
    @Published var name = ""
    @Published var date = Date.now
    @Published var amount = ""
    @Published var type = PaymentCategory.expense
    
    //output
    @Published var isNameValid = false
    @Published var isAmountValid = false
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    init(paymentActivity: PaymentActivity?) {
        
        
        self.name = paymentActivity?.name ?? ""
        self.amount = "\(paymentActivity?.amount ?? 0.0)"
        self.type = paymentActivity?.type ?? .expense
        self.date = paymentActivity?.date ?? Date.today
        
        
        $name
            .receive(on: RunLoop.main)
            .map { name in
                return name.count > 0
            }
            .assign(to: \.isNameValid, on: self)
            .store(in: &cancellableSet)
        
        $amount
            .receive(on: RunLoop.main)
            .map { amount in
                guard let validAmount = Double(amount) else {
                    return false
                }
                return validAmount > 0
            }
            .assign(to: \.isAmountValid, on: self)
            .store(in: &cancellableSet)
    }
}
