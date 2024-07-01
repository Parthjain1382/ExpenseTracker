import UIKit
import FirebaseDatabase

class AddNewExpenseViewController: UIViewController {
    
    static let identifier = "AddNewExpenseViewController"
    
    
    private let databaseRef = Database.database().reference()
    
    var userData = (email: String(), uid: String())
    
    // UI Elements
    let userIdTextField = UITextField()
    let amountTextField = UITextField()
    let categoryTextField = UITextField()
    let dateTextField = UIDatePicker()
    let descriptionTextField = UITextField()
    let billImageView = UIImageView()
    let categoryPicker = UIPickerView()
    let submitButton = UIButton(type: .system) // Define the button
    
    // Sample Data for Category Dropdown
    let categories = ["Groceries", "Rent", "Utilities", "Entertainment"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupCategoryPicker()
        setupNavigationBar()
    }
    
    func setupUI() {
        view.backgroundColor = .white
    
        // Configure Text Fields
        userIdTextField.text = userData.email
        userIdTextField.isEnabled = false // Make the User ID field non-editable
        configureTextField(userIdTextField, placeholder: "")
        configureTextField(amountTextField, placeholder: "Amount")
        amountTextField.keyboardType = .numberPad
        configureTextField(categoryTextField, placeholder: "Category")
        configureTextField(descriptionTextField, placeholder: "Description")
        
        // Configure Date Picker
        dateTextField.datePickerMode = .date
        dateTextField.translatesAutoresizingMaskIntoConstraints = false
        let datePickerContainer = UIView()
        datePickerContainer.translatesAutoresizingMaskIntoConstraints = false
        datePickerContainer.addSubview(dateTextField)
        
        NSLayoutConstraint.activate([
            dateTextField.leadingAnchor.constraint(equalTo: datePickerContainer.leadingAnchor),
            dateTextField.trailingAnchor.constraint(equalTo: datePickerContainer.trailingAnchor),
            dateTextField.topAnchor.constraint(equalTo: datePickerContainer.topAnchor),
            dateTextField.bottomAnchor.constraint(equalTo: datePickerContainer.bottomAnchor)
        ])
        
        // Configure Bill Image View
        billImageView.image = UIImage(named: "tran_img")
        billImageView.contentMode = .scaleAspectFit
        billImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(billImageView)
        
        // Configure Submit Button
        submitButton.setTitle("Submit", for: .normal)
        submitButton.addTarget(self, action: #selector(addNewTrans), for: .touchUpInside)
        submitButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        submitButton.backgroundColor = .systemBlue
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.layer.cornerRadius = 10
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(submitButton)
        
        // Add Text Fields to View
        let stackView = UIStackView(arrangedSubviews: [
            createRow(first: userIdTextField, second: amountTextField),
            createRow(first: categoryTextField, second: datePickerContainer),
            createRow(first: descriptionTextField)
        ])
        
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        // Constraints
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            billImageView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 32),
            billImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            billImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            billImageView.heightAnchor.constraint(equalToConstant: 350),
            
            submitButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            submitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            submitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            submitButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    func configureTextField(_ textField: UITextField, placeholder: String) {
        textField.placeholder = placeholder
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func createRow(first: UIView, second: UIView? = nil) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [first])
        if let second = second {
            stackView.addArrangedSubview(second)
        }
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        return stackView
    }
    
    func setupCategoryPicker() {
        categoryPicker.dataSource = self
        categoryPicker.delegate = self
        categoryTextField.inputView = categoryPicker
    }
    
    func setupNavigationBar() {
        self.navigationItem.title = "Transactions"
    }
    
    @objc func addNewTrans(){
        addNewDataInDatabase(userData)
    }
    
    //Add the New Added User to the Database
    func addNewDataInDatabase(_ userData : (email: String, uid: String)){
        let transactionId = UUID().uuidString
       
        let amountText = amountTextField.text ?? "0.0" // Provide a default value
        let amount = Double(amountText) ?? 0.0
        
        let transaction = Transaction(userId: "trans" + userData.uid, amount: amount  , category: categoryTextField.text ?? "No option", date: formatDate(dateTextField.date), description: descriptionTextField.text ?? "No description")
        
        let transDict = convertTransactionToDictionary(transaction)
        let tranChangeInUser: [String: Bool] = [
                transactionId : true
         ]
        
        updateExpectedAmount(amount)
        
        databaseRef.child("transactions").child(transactionId).setValue(transDict)
        databaseRef.child("Users").child(userData.uid).child("transaction").updateChildValues(tranChangeInUser)
    }
    
    
    func updateExpectedAmount(_ amount : Double){
        let userRef = databaseRef.child("Users").child(userData.uid)
        
        // Read the current expectedAmount
        userRef.child("expectedAmount").observeSingleEvent(of: .value) { snapshot in
            if let currentExpectedAmount = snapshot.value as? Double {
                
                let newExpectedAmount = currentExpectedAmount - amount
                
                // Update the database with the new expectedAmount
                userRef.child("expectedAmount").setValue(newExpectedAmount) { error, _ in
                    if let error = error {
                        print("Error updating expectedAmount: \(error.localizedDescription)")
                    } else {
                        print("expectedAmount updated successfully to \(newExpectedAmount)")
                    }
                }
            } else {
                print("Error: expectedAmount not found or not a valid number")
            }
        }
    }
    
    func convertTransactionToDictionary(_ transaction: Transaction) -> [String: Any] {
        var transactionDict: [String: Any] = [:]
        transactionDict["userId"] = transaction.userId
        transactionDict["amount"] = transaction.amount
        transactionDict["category"] = transaction.category
        transactionDict["date"] = transaction.date
        transactionDict["description"] = transaction.description
        return transactionDict
    }


    func formatDate(_ datePicked : Date) -> String{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd" // Set the desired date format
            return dateFormatter.string(from: datePicked)
    }
    
}

// MARK: - UIPickerViewDataSource, UIPickerViewDelegate
extension AddNewExpenseViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        categoryTextField.text = categories[row]
        categoryTextField.resignFirstResponder()
    }
}

