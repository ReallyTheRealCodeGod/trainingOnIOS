//
//  LoginViewController.swift
//  trainingOnIOS
//
//  Created by Rasmus Sejer on 11/03/2021.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var topPictureFlexing: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.alpha = 0
        
        passwordTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.autocapitalizationType = .none
        passwordTextField.autocorrectionType = .no
        emailTextField.autocapitalizationType = .none
        emailTextField.autocorrectionType = .no
        
            // Do any additional setup after loading the view.
    }
    
    //used to change flexing picture on front page
    //so it can create an animation when typing
    var flexNum = 1
    
    @IBAction func changeFlexPicture(_ sender: UITextField) {
        
        topPictureFlexing.image = UIImage(named: "loginPictureFlex_\(flexNum)")
        
        //facilitates the change in picture on the login screen
        if(flexNum == 1) {
            flexNum = 2
        }else{
            flexNum = 1
        }
        
        
        
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    
    
    // hvorfor er kineserne så gule? det er fordi de elsker citron
    // pølle
}
