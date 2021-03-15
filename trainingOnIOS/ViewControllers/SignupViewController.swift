//
//  SignupViewController.swift
//  trainingOnIOS
//
//  Created by Rasmus Sejer on 11/03/2021.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseStorage

class SignupViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Makes label invisible
        errorLabel.alpha = 0
        
        // Do any additional setup after loading the view.
    }
    
    // Method returns true if regex is valid (Must contain letters, a special character and be longer than 6 characters)
    func isPasswordValid(_ password: String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[a-z])(?=.*[$@$#!%*?&]).{6,}$")
        return passwordTest.evaluate(with: password)
    }
    
    func isEmailValid(_ email: String) -> Bool {
        let emailTest = NSPredicate(format: "SELF MATCHES %@ ", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
        return emailTest.evaluate(with: email)
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
            return "Invalid email"
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
            // Creating trimmed versions of the data
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // Create user
            Auth.auth().createUser(withEmail: email, password: password) { (result, Error) in
                
                // Check for errors
                if error != nil {
                    // There was an error while creating a user
                    self.showError("Error while creating user")
                } else {
                    // User created succesfully - Store fName + lName in firebase
                    let db = Firestore.firestore()
                    
                    db.collection("users").addDocument(data: ["firstName": firstName, "lastName":lastName, "uid": result!.user.uid]) { (error) in
                        
                        if error != nil {
                            // There was an error placing first and lastname to cloud firebase
                            // A user i still created at this point
                            self.showError("First and lastname not saved in firebase")
                            // should maybe be handled in an other way than an error message
                            
                        } // else user data saved to firebase
                    }
                    
                    // Transition to homepage
                    self.transitionToHome()
                    
                }
            }
            
        }
        
    }
    
    // Method for showing text in the error label
    func showError(_ message: String) {
        errorLabel.text = message
        // Makes the Label visible
        errorLabel.alpha = 1
    }
    
    // Changes root view controller to 'storyboard ID'
    func transitionToHome(){
        
        // making a reference to our HomeViewController
        // Instanciating a viewController and casting it as a HomeViewController
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        view.window?.rootViewController = homeViewController
        // Will show 'HomeViewController' as the root view controller
        view.window?.makeKeyAndVisible()
    }
    
}
