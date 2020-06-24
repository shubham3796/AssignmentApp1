//
//  SignUpViewController.swift
//  assignmentApp
//
//  Created by Pranjal Singhai on 28/05/20.
//  Copyright © 2020 Capgemini. All rights reserved.
//

import UIKit


class SignUpViewController: UIViewController, UITextFieldDelegate {

// MARK: Properties
    
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    @IBOutlet weak var addressTextField: UITextField!
    
    private var userName = "NA"
    private var lastName = "NA"
    private var email = "NA"
    private var phoneNumber = 0
    private var address = "NA"
    let signUpVCStoreManager = SignUpVCStoreManager()
    
// MARK: Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
    
        // Do any additional setup after loading the view.
    }

    func setDelegates(){
        userNameTextField.delegate = self
        lastNameTextField.delegate = self
        emailTextField.delegate = self
        phoneNumberTextField.delegate = self
        addressTextField.delegate = self
    }
    
// MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == userNameTextField{
            userName = userNameTextField.text ?? "NA"
        }
        else if textField == lastNameTextField{
            lastName = lastNameTextField.text ?? "NA"
        }
        else if textField == emailTextField{
            email = emailTextField.text ?? "NA"
        }
        else if textField == phoneNumberTextField{
            phoneNumber = Int(phoneNumberTextField.text ?? "NA") ?? 0
        }
        else if textField == addressTextField {
            address = addressTextField.text ?? "NA"
        }
    }
    
// MARK: Actions
    
    @IBAction func saveData(_ sender: UIButton) {
        
        let newUser = PojoClass(userName: userName, lastName: lastName, email: email, phoneNumber: phoneNumber, address: address)
        
        _ = signUpVCStoreManager.insertUser(newUser: newUser)

        
    }
    
    @IBAction func fetchData(_ sender: UIButton) {
        _ = signUpVCStoreManager.fetchAll()
    }
}

