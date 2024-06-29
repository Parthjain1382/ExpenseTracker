//
//  HomeViewController.swift
//  Danam2.0
//
//  Created by E5000846 on 28/06/24.
//

import UIKit
import Firebase
import FirebaseDatabase

class HomeViewController: UIViewController {
   
    static let identifier = "HomeViewController"
    
    private let databaseRef = Database.database().reference()
        
    // UI Elements
    let profileLabel = UILabel()
    let totalExpenseLabel = UILabel()
    let totalExpenseCardView = UIView()
    let transactionHeadingLabel = UILabel()
    let transcationData = [Transaction(userId: "", amount: 122, category: "", date: "", description: "")]

    //This contains Uid and email Id
    var userData: (email: String, uid: String)!
 
    @IBOutlet weak var tableView: UITableView!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            setupUI()
            setupTableView()
            setupNavigationBar()
            FetchData()
        }
        
    
        func setupUI() {
            view.backgroundColor = .white
            
            // Profile Label
            profileLabel.text = "Hi,\(userData.0)"
            profileLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
            profileLabel.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(profileLabel)
            
            // Total Expense Card View
            totalExpenseCardView.backgroundColor = .yellow
            totalExpenseCardView.layer.cornerRadius = 10
            totalExpenseCardView.layer.shadowColor = UIColor.black.cgColor
            totalExpenseCardView.layer.shadowOpacity = 0.1
            totalExpenseCardView.layer.shadowOffset = CGSize(width: 0, height: 2)
            totalExpenseCardView.layer.shadowRadius = 4
            totalExpenseCardView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(totalExpenseCardView)
            
            // Total Expense Label
            totalExpenseLabel.text = "Total Expense: $1400.00"
            totalExpenseLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
            totalExpenseLabel.translatesAutoresizingMaskIntoConstraints = false
            totalExpenseCardView.addSubview(totalExpenseLabel)
            
            // Transaction Heading Label
            transactionHeadingLabel.text = "Transactions"
            transactionHeadingLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            transactionHeadingLabel.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(transactionHeadingLabel)
    
            
            // Constraints
            NSLayoutConstraint.activate([
                profileLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
                profileLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                
                totalExpenseCardView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                totalExpenseCardView.topAnchor.constraint(equalTo: profileLabel.bottomAnchor, constant: 32),
                totalExpenseCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                totalExpenseCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                totalExpenseCardView.heightAnchor.constraint(equalToConstant: 100),
                
                totalExpenseLabel.centerXAnchor.constraint(equalTo: totalExpenseCardView.centerXAnchor),
                totalExpenseLabel.centerYAnchor.constraint(equalTo: totalExpenseCardView.centerYAnchor),
                
                transactionHeadingLabel.topAnchor.constraint(equalTo: totalExpenseCardView.bottomAnchor, constant: 35),
                transactionHeadingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
           
                tableView.topAnchor.constraint(equalTo: transactionHeadingLabel.bottomAnchor, constant: 10),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }
        
    func setupNavigationBar() {
        
                // Create a UIBarButtonItem with a plus icon
                let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
                // Create a UILabel for the logo text
                let logoLabel = UILabel()
                logoLabel.text = "Expense Tracker" // Replace with your logo text
                logoLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
                logoLabel.textColor = .darkGray // Set the desired text color
                logoLabel.sizeToFit()
              
                let logoButton = UIBarButtonItem(customView: logoLabel)
        
                navigationItem.rightBarButtonItems = [addButton]
                navigationItem.leftBarButtonItem = logoButton
        }
        
        @objc func addButtonTapped() {
            let vc = UIStoryboard(name: "Main", bundle: nil)
            let addNewExpenseVc = vc.instantiateViewController(withIdentifier: AddNewExpenseViewController.identifier) as! AddNewExpenseViewController
            addNewExpenseVc.userData = self.userData
            navigationController?.pushViewController(addNewExpenseVc, animated: true)
        }
    
        func setupTableView() {
            tableView.dataSource = self
            tableView.delegate = self
        }
    
        func FetchData(){
            
        }
    }

    // MARK: - UITableViewDataSource, UITableViewDelegate
    extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: TransactionTableViewCell.identifer, for: indexPath) as! TransactionTableViewCell
            cell.tranHeadingLb.text = "Grocery"
            cell.transDescLb.text = "This is the grocery"
            cell.amountSpendLb.text = "200"
            
            return cell
        }
        
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 100
        }
    }


    

