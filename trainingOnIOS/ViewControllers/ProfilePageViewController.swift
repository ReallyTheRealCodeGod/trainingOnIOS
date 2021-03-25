//
//  ProfilePageViewController.swift
//  trainingOnIOS
//
//  Created by Peter Bandsholm on 25/03/2021.
//

import UIKit
import FirebaseAuth

class ProfilePageViewController: UIViewController {

    @IBOutlet weak var userName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if Auth.auth().currentUser != nil {
          // User is signed in.
          // ...
            let user = Auth.auth().currentUser
            if let user = user {
              // The user's ID, unique to the Firebase project.
              // Do NOT use this value to authenticate with your backend server,
              // if you have one. Use getTokenWithCompletion:completion: instead.
              let uid = user.uid
              let email = user.email
                userName.text = email
                
              print(uid)
                print(email!)
                print("test")
                var multiFactorString = "MultiFactor: "
              for info in user.multiFactor.enrolledFactors {
                multiFactorString += info.displayName ?? "[DispayName]"
                multiFactorString += " "
              }
              // ...
            }
        } else {
            print("no user")
          // No user is signed in.
          // ...
        }
    }
    

    
    
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
