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
    @IBOutlet var backgroundGradientView: UIView!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var logInButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [#colorLiteral(red: 0.95, green: 0.98, blue: 1, alpha: 1).cgColor, UIColor(red: 219/255, green: 245/255, blue: 255/255, alpha: 1).cgColor]
        
        backgroundGradientView.layer.addSublayer(gradientLayer)
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        
        // Sign Up Button Shadow
        signUpButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        signUpButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        signUpButton.layer.shadowOpacity = 1.0
        signUpButton.layer.shadowRadius = 0.0
        signUpButton.layer.masksToBounds = false
        signUpButton.layer.cornerRadius = 4.0
        
        // Log In Button Shadow
        logInButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        logInButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        logInButton.layer.shadowOpacity = 1.0
        logInButton.layer.shadowRadius = 0.0
        logInButton.layer.masksToBounds = false
        logInButton.layer.cornerRadius = 4.0
    }
    
    override var shouldAutorotate: Bool{
        return false
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
                    let alertController = UIAlertController(title: "Error", message:
                        "Invalid Username or Password", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))

                    self.present(alertController, animated: true, completion: nil)
                    
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

