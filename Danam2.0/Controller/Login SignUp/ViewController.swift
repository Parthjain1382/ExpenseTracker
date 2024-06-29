//
//  ViewController.swift
//  Danam2.0
//
//  Created by E5000846 on 28/06/24.
//

import UIKit
import Firebase
import FirebaseDatabase

class ViewController: UIViewController {
    let transactionId = UUID().uuidString
    
    func addUser(userId: String, name: String, email: String) {
        let databaseRef = Database.database().reference()
        let userRef = databaseRef.child("users").child(userId)
        
        let userData: [String: Any] = [
            "name": name,
            "email": email,
            "transactions": [:]
        ]
        
        userRef.setValue(userData) { error, _ in
            if let error = error {
                print("Error adding user: \(error)")
            } else {
                print("User added successfully")
            }
        }
    }

    func addTransaction(userId: String, transactionId: String, amount: Double, category: String, date: String, description: String) {
        let databaseRef = Database.database().reference()
        let transactionRef = databaseRef.child("transactions").child(transactionId)
        
        let transactionData: [String: Any] = [
            "userId": userId,
            "amount": amount,
            "category": category,
            "date": date,
            "description": description
        ]
        
        transactionRef.setValue(transactionData) { error, _ in
            if let error = error {
                print("Error adding transaction: \(error)")
            } else {
                print("Transaction added successfully")
                
                // Update user's transactions
                let userTransactionRef = databaseRef.child("users").child(userId).child("transactions").child(transactionId)
                userTransactionRef.setValue(true)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        addUser(userId: "1231", name: "pranay", email: "pranayjain1382@gmail.com")
//        addTransaction(userId: "1231", transactionId: "znc,nz", amount: 123.0, category: "Food", date: "12 august", description: "Food spend")
    }

  
    @IBAction func loginBtn(_ sender: UIButton) {
    }
    
    
    @IBAction func SignInNewUserBtn(_ sender: UIButton) {
    }
}

