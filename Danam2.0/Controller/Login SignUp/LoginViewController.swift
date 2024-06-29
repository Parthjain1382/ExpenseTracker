//
//  LoginViewController.swift
//  Danam2.0UITests
//
//  Created by E5000846 on 28/06/24.
//
import UIKit
import Firebase
import FirebaseDatabase

class LoginViewController: UIViewController {
    
    static let identifier = "LoginViewController"
    
    private let databaseRef = Database.database().reference()
        
    // This contains Uid and email Id
    var userData: (email: String, uid: String)?
    
    @IBOutlet weak var headinLb: UILabel!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginBtn(_ sender: UIButton) {
        guard let email = emailTxtField.text else { return }
        guard let password = passwordTxtField.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) {
           (firebaseResult, error) in
            if let e = error {
                print(e.localizedDescription)
            } else {
                if let authResult = firebaseResult {
                    let user = authResult.user
                    self.userData = (user.email!, user.uid)
                    let vc = UIStoryboard(name: "Main", bundle: nil)
                    let tabVc = vc.instantiateViewController(withIdentifier: HomeViewController.identifier) as! HomeViewController
                    tabVc.userData = self.userData
                    self.navigationController?.setViewControllers([tabVc], animated: true)
                } else {
                    print("Authentication failed or authResult is nil")
                }
            }
        }
    }
}

