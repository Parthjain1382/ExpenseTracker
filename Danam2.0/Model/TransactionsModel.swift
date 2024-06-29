//
//  TransactionsModel.swift
//  Danam2.0
//
//  Created by E5000846 on 29/06/24.
//

import Foundation

class Transaction {
    var transactionId: String
    var userId: String
    var amount: Double
    var category: String
    var date: String
    var description: String
    
    init(transactionId: String, userId: String, amount: Double, category: String, date: String, description: String) {
        self.transactionId = transactionId
        self.userId = userId
        self.amount = amount
        self.category = category
        self.date = date
        self.description = description
    }

    func toDictionary() -> [String: Any] {
        return [
            "userId": userId,
            "amount": amount,
            "category": category,
            "date": date,
            "description": description
        ]
    }
}
