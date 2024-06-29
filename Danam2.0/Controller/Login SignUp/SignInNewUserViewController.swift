//
//  SignInNewUserViewController.swift
//  Danam2.0UITests
//
//  Created by E5000846 on 28/06/24.
//

import UIKit
import Firebase
import FirebaseDatabase

class SignInNewUserViewController: UIViewController {
    
    private let databaseRef = Database.database().reference()
    
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var HeadingLb: UILabel!
    
    // This contains Uid and email Id
    var userData: (email: String, uid: String)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signInNewUserBtn(_ sender: UIButton) {
        
        guard let email = emailTxtField.text else{return}
        guard let password = passwordTxtField.text else{return}
        
        //Creating a New user
        Auth.auth().createUser(withEmail: email, password: password){
            (firebaseResult , error) in
            
            if let e = error{
                print(e)
            }
            else {
                if let authResult = firebaseResult {
                    let user = authResult.user
                    self.userData = (user.email!, user.uid)
                    addNewDataInDatabase(self.userData!)
                    let vc = UIStoryboard(name: "Main", bundle: nil)
                    let tabVc = vc.instantiateViewController(withIdentifier: HomeViewController.identifier) as! HomeViewController
                    tabVc.userData = self.userData
                    self.navigationController?.setViewControllers([tabVc], animated: true)
                } else {
                    print("Authentication failed or authResult is nil")
                }
            }
        }
        
        //Add the New Added User to the Database
        func addNewDataInDatabase(_ userData : (email: String, uid: String)){
            let transactions: [String: Bool] = [:]
            
            let user = User(email: userData.email, uid: userData.uid, transactions: transactions, expectedAmount: 400.0)
            let userDict = convertUserToDictionary(user: user)
            databaseRef.child("Users").child("\(user.uid)").setValue(userDict)
        }
        
        func convertUserToDictionary(user: User) -> [String: Any] {
            var userDict: [String: Any] = [:]
            userDict["email"] = user.email
            userDict["expectedAmount"] = String(user.expectedAmount)
            userDict["uid"] = String(user.uid)
            userDict["transactions"] = user.transactions
            return userDict
        }
        
    }
}
