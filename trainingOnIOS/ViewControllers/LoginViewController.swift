//
//  LoginViewController.swift
//  trainingOnIOS
//
//  Created by Rasmus Sejer on 11/03/2021.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.alpha = 0
            // Do any additional setup after loading the view.
    }
    

    @IBAction func loginButtonPressed(_ sender: UIButton) {
        
        // Validate that textFields are filled out
        let error = validateFields()
        
        if error != nil {
            // Shows the returned error (String) from validateFields()
            errorLabel.text = error
            errorLabel.alpha = 1
        } else {
        // Creating trimmed versions of the data
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // User login
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            if error != nil {
                // Login failed
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
            }
            else {
                
                let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
                
                self.view.window?.rootViewController = homeViewController
                // Will show 'HomeViewController' as the root view controller
                self.view.window?.makeKeyAndVisible()
                }
            }
        }
    }
    
    
    func validateFields() -> String? {
        
        // Checks if all fields are filled in - All whitespaces removed
        if  emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields!"
        }
        
        return nil
    }
    
    
    // TEKST
}
