//
//  PaymentActivity.swift
//  Momo
//
//  Created by Tsenguun on 4/8/22.
//

import Foundation
import CoreData

//Core Data Model
enum PaymentCategory: Int {
    case income = 0
    case expense = 1
}

public class PaymentActivity: NSManagedObject {
    @NSManaged public var paymentID: UUID
    @NSManaged public var date: Date
    @NSManaged public var name: String
    @NSManaged public var amount: Double
    @NSManaged public var typeNum: Int32
}

extension PaymentActivity: Identifiable {
    var type: PaymentCategory {
        get {
            return PaymentCategory(rawValue: Int(typeNum)) ?? .expense
        }
        
        set {
            self.typeNum = Int32(newValue.rawValue)
        }
    }
}
