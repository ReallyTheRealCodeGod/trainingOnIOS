//
//  SignupViewController.swift
//  trainingOnIOS
//
//  Created by Rasmus Sejer on 11/03/2021.
//

import UIKit

class SignupViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.alpha = 0
        // Do any additional setup after loading the view.
    }
    
    // Method returns true if regex is valid (Must contain letters, a special character and be longer than 6 characters)
    func isPasswordValid(_ password: String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[a-z])(?=.*[$@$#!%*?&]).{6,}$")
        return passwordTest.evaluate(with: password)
    }
    
    func isEmailValid(_ email: String) -> Bool {
        
        return true
    }
    
    // Validating fields. If correct return nil else return error message in errorLabel
    func validateFields() -> String? {
        
        // Checks if all fields are filled in - All whitespaces removed
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields!"
        }
        
        // Check if password is secure
        if isPasswordValid(passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)) == false {
            // Password is not secure enough
            return "Make sure your password is at least 6 characters long, containing both letters and a special character ($@$#!%*?&)"
        }
        
        // Check if email is valid
        if isEmailValid(emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)) == false {
            // Email not valid
        }
        
       return nil
    }
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        // Validate Fields
        let error = validateFields()
        if error != nil {
            // Something went wrong while validating fields
            showError(error!)
        } else {
            
            // Create user
            
            // Transition to homepage
        }
        
    }
    
    func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
}
