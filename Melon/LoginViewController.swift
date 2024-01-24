//
//  LoginViewController.swift
//  Melon
//
//  Created by kibam kang on 11/20/23.
// kibam Kang
// kk33556 

import UIKit
import FirebaseAuth
//add Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var loginSegCtrl: UISegmentedControl!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPasswordLabel: UILabel!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var loginButtonField: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loginSegCtrl.backgroundColor = UIColor.init(red: 48/255, green: 173/255, blue: 99/255, alpha: 1)
        loginSegCtrl.layer.cornerRadius = 25.0
        loginSegCtrl.tintColor = UIColor.white
        loginButtonField.backgroundColor = UIColor.init(red: 48/255, green: 173/255, blue: 99/255, alpha: 1)
        loginButtonField.layer.cornerRadius = 25.0
        loginButtonField.tintColor = UIColor.black
        confirmPasswordLabel.isHidden = true
        confirmPassword.isHidden = true
        passwordField.isSecureTextEntry = true
        Auth.auth().addStateDidChangeListener() {
            (auth,user) in
            if (user != nil) {
                self.performSegue(withIdentifier: "LoginSegue", sender: nil)
                self.emailField.text = nil
                self.passwordField.text = nil
                self.confirmPassword.text = nil
            }
        }
    }
    
    @IBAction func segmentChanged(_ sender: Any) {
        //switching from login segment to sign up segment and vice versa
        switch loginSegCtrl.selectedSegmentIndex {
        case 0:
            confirmPasswordLabel.isHidden = true
            confirmPassword.isHidden = true
            passwordField.isSecureTextEntry = true
            loginButtonField.setTitle("Login", for: .normal)
        case 1:
            confirmPasswordLabel.isHidden = false
            confirmPassword.isHidden = false
            passwordField.isSecureTextEntry = false
            loginButtonField.setTitle("Sign Up", for: .normal)
        default:
            print("error in segmentChanged")
            break
        }
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        if (loginButtonField.titleLabel?.text == "Sign Up") {
            //Sign Up Process
            Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!) {
                (authResult,error) in
                if let error = error as NSError? {
                    print("\(error.localizedDescription)")
                } else {
                    print("no error")
                }
                self.emailField.text = nil
                self.passwordField.text = nil
                self.confirmPassword.text = nil
            }
        } else {
            //Sign In Process
            Auth.auth().signIn(withEmail:emailField.text!, password: passwordField.text!) {
                (authResult,error) in
                if let error = error as NSError? {
                    print("\(error.localizedDescription)")
                } else {
                    print("no error")
                }
                self.emailField.text = nil
                self.passwordField.text = nil
                self.confirmPassword.text = nil
            }
        }
    }
}
