//
//  ViewController.swift
//  ViewsCommunication
//
//  Created by Alberto González Hernández on 19/11/20.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, EndDelegate {

    @IBOutlet weak var loginDataContainer: UIStackView!
    @IBOutlet weak var sendTextContainer: UIStackView!
    @IBOutlet weak var userResultLabel: UILabel!
    @IBOutlet weak var pwdResultLabel: UILabel!
    @IBOutlet weak var textToSendTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Hide keyboard
        textToSendTextField.delegate = self
        self.hideKeyboardWhenTappedAround()

        // Initially don't display app data fields
        showUIElements(areShown: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        presentActionSheet()
    }
    
    private func presentActionSheet() {
        let alert = UIAlertController(title: "Select app color", message: "Change the app color by selecting one of the options", preferredStyle: .actionSheet)
        let setDark = UIAlertAction(title: "Color green", style: .default) { (actn) in
            self.view.backgroundColor = UIColor(red: 0.8, green: 1, blue: 0.9, alpha: 1)
            self.presentAlertView()
        }
        let setLight = UIAlertAction(title: "Color red", style: .default) { (actn) in
            self.view.backgroundColor = UIColor(red: 1, green: 0.9, blue: 0.8, alpha: 1)
            self.presentAlertView()
        }
        let setBlue = UIAlertAction(title: "Color blue", style: .default) { (actn) in
            self.view.backgroundColor = UIColor(red: 0.8, green: 0.9, blue: 1, alpha: 1)
            self.presentAlertView()
        }
        alert.addAction(setDark)
        alert.addAction(setLight)
        alert.addAction(setBlue)
        present(alert, animated: true)
        
    }

    private func presentAlertView() {
        let alert = UIAlertController(title: "Introduce user credentials", message: "",
        preferredStyle: .alert)
        let action = UIAlertAction(title: "Login", style: .default, handler: { actn in
            let user = alert.textFields![0].text!
            let pwd = alert.textFields![1].text!
            self.setLoginValues(user: user, pwd: pwd)
        })
        alert.addTextField { (userTextField) in
            userTextField.placeholder = "Username"
        }
        alert.addTextField { (pwdTextField) in
            pwdTextField.isSecureTextEntry = true
            pwdTextField.placeholder = "Password"
        }
        alert.addAction(action)
        
        present(alert, animated: true)
    }
    
    private func setLoginValues(user: String, pwd: String) {
        if !user.isEmpty || !pwd.isEmpty {
            showUIElements(areShown: true)
            self.userResultLabel.text = user
            self.pwdResultLabel.text = pwd
        } else {
            presentActionSheet()
        }
    }

    private func showUIElements(areShown: Bool) {
        sendTextContainer.alpha = areShown ? 1 : 0
        loginDataContainer.alpha = areShown ? 1 : 0
    }
    
    // Navigation for views

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Passing data to child
        if segue.destination.view != nil {
            let editTextViewCtrl = segue.destination as! EditTextViewController
            editTextViewCtrl.textToDisplayTextField.text = textToSendTextField.text
        }
        
        // Using delegate method
        (segue.destination as! EditTextViewController).delegate = self
        
        // Using closure method
        (segue.destination as! EditTextViewController).callBack = { (result) in self.textToSendTextField.text = result}
    }
    
    // Using delegate method
    func childDone(result: String) {
        textToSendTextField.text = result
    }
    
    // Using unwind method
    @IBAction func closeWithUnwind (segue: UIStoryboardSegue) {
        let res = (segue.source as! EditTextViewController).textToDisplayTextField.text
        textToSendTextField.text = res
    }
    
    // Hide keyboard
    
    // Hide when click enter in keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

// Hide keyboard when tapp around
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

