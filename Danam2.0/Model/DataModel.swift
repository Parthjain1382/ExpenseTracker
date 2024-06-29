import Foundation



struct User: Codable {
    let email : String
    let uid : String
    let transactions : [String: Bool]
    let expectedAmount : Double
}

struct Transaction: Codable {
    let userId : String
    let amount : Double
    let category:  String
    let date : String
    let description : String
}

struct DataOfUserAndTranscation : Codable {
    let users : [String: User]
    let transactions : [String: Transaction]
}
//
//// Example usage
//let jsonString = """
//{
//  "users": {
//    "userId1": {
//      "name": "John Doe",
//      "email": "john.doe@example.com",
//      "transactions": {
//        "transactionId1": true,
//        "transactionId2": true
//      }
//    },
//    "userId2": {
//      "name": "Jane Smith",
//      "email": "jane.smith@example.com",
//      "transactions": {
//        "transactionId3": true
//      }
//    }
//  },
//  "transactions": {
//    "transactionId1": {
//      "userId": "userId1",
//      "amount": 100.0,
//      "category": "Groceries",
//      "date": "2024-06-28",
//      "description": "Weekly groceries"
//    },
//    "transactionId2": {
//      "userId": "userId1",
//      "amount": 50.0,
//      "category": "Transport",
//      "date": "2024-06-27",
//      "description": "Bus pass"
//    },
//    "transactionId3": {
//      "userId": "userId2",
//      "amount": 200.0,
//      "category": "Rent",
//      "date": "2024-06-26",
//      "description": "Monthly rent"
//    }
//  }
//}
//"""
//
//
//
