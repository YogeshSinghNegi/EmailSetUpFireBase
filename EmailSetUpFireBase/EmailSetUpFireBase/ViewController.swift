//
//  ViewController.swift
//  EmailSetUpFireBase
//
//  Created by appinventiv on 05/09/17.
//  Copyright © 2017 yogesh singh negi. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    
    @IBOutlet weak var signInSelector: UISegmentedControl!
    
    @IBOutlet weak var signInLabel: UILabel!
    
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signInBtnName: UIButton!
    
    var isSignIn:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signInSelectorChanged(_ sender: UISegmentedControl) {
        
        // toggel boolean
        self.isSignIn = !self.isSignIn
        
        // Changing the title of the button and label accordingly
        if self.isSignIn {
            self.signInLabel.text = "Sign In"
            self.signInBtnName.setTitle("Sign In", for: .normal)
        }
        else {
            self.signInLabel.text = "Register"
            self.signInBtnName.setTitle("Register", for: .normal)
        }
        
    }
    
    // To dismiss the keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    @IBAction func SignInBtnTapped(_ sender: UIButton) {
        
        if let email = self.userNameTextField.text, let pass = self.passwordTextField.text {
            
            if self.isSignIn {
                // Sign In User
                Auth.auth().signIn(withEmail: email, password: pass, completion: { (user, error) in
                    
                    if let u = user {
                        // User Exits
                        self.performSegue(withIdentifier: "goToHome", sender: self)
                    }
                    else {
                        // Error: Check error ans show message
                    }
                    
                })
            }
            else {
                // Register User
                Auth.auth().createUser(withEmail: email, password: pass, completion: { (user, error) in
                    if let u = user {
                        // User is found
                        self.performSegue(withIdentifier: "goToHome", sender: self)
                    }
                    else {
                        //Error: Check error and go to the home screen
                    }
                })
            }
            
        }
    }
    
}

