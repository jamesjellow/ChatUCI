//
//  ViewController.swift
//  ChatterBox
//


/*------ Comment ------*/


import UIKit
import Parse

class LoginViewController: UIViewController {

    
    /*------ Outlets ------*/
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    
    /*------ SIGN UP AND LOG IN FUNCTIONALITY  ------*/
    
    // TODO: SIGN UP FUNCTIONALITY
    @IBAction func onSignUp(_ sender: Any) {
        // Sign up user
        // Check text field inputs
        if usernameAndPasswordNotEmpty(){
            let newUser = PFUser()
            
            newUser.username = usernameTextField.text
            newUser.password = passwordTextField.text
            
            newUser.signUpInBackground{ (success: Bool, error: Error?) in
                if let error = error { print(error.localizedDescription)
                    self.displaySignupError(error:error)
                } else{
                    print("User \(newUser.username!) Registered!")
                    self.performSegue(withIdentifier: Segues.authenticated, sender: nil)
                }
            }
        }
        
    }
    
    
    // TODO: LOG IN FUNCTIONALITY
    @IBAction func onLogin(_ sender: Any) {
        // Login user
        // Check text field inputs
        if usernameAndPasswordNotEmpty(){
            let username = usernameTextField.text!
            let password = passwordTextField.text!
            
            PFUser.logInWithUsername(inBackground: username, password: password) { ( user: PFUser?, error: Error?) in
                if let error = error {
                    print("User login failed \(error.localizedDescription)")
                }else {
                    print("User \(username) logged in successfully")
                    self.performSegue(withIdentifier: Segues.authenticated, sender: nil)
                }
            }
        }
    
        
    }
    
    
    /*------ Handle text field inputs  ------*/
    func usernameAndPasswordNotEmpty() -> Bool {
        // Check text field inputs
        if usernameTextField.text!.isEmpty || passwordTextField.text!.isEmpty {
            displayError()
            return false
        } else {
            return true
        }
    }
    
    
    
    /*------ Alert Controllers ------*/
    // Text fields are empty alert controller
    func displayError() {
        let title = "Error"
        let message = "Username and password field cannot be empty"
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        // create an OK action
        let OKAction = UIAlertAction(title: "OK", style: .default)
        // add the OK action to the alert controller
        alertController.addAction(OKAction)
        present(alertController, animated: true)
    }
    
    
    // Login error alert controller
    func displayLoginError(error: Error) {
        let title = "Login Error"
        let message = "Oops! Something went wrong while logging in: \(error.localizedDescription)"
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        // create an OK action
        let OKAction = UIAlertAction(title: "OK", style: .default)
        // add the OK action to the alert controller
        alertController.addAction(OKAction)
        present(alertController, animated: true)
    }
    
    
    // Sign up error alert controller
    func displaySignupError(error: Error) {
        let title = "Sign up error"
        let message = "Oops! Something went wrong while signing up: \(error.localizedDescription)"
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        // create an OK action
        let OKAction = UIAlertAction(title: "OK", style: .default)
        // add the OK action to the alert controller
        alertController.addAction(OKAction)
        present(alertController, animated: true)
    }
    
    
    
    
    
}

