//
//  EditTextViewController.swift
//  ViewsCommunication
//
//  Created by Alberto González Hernández on 19/11/20.
//

import UIKit

// Using delegate method
protocol EndDelegate {
    func childDone (result: String)
}

class EditTextViewController: UIViewController {
    
    @IBOutlet weak var textToDisplayTextField: UITextField!
    
    // Callback for closure method
    public var callBack: ((String) -> ())?
    // Delegate for delegate method
    public var delegate: EndDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // Using delegate method
    @IBAction func closeWithDelegate(_ sender: UIButton) {
        delegate?.childDone(result: textToDisplayTextField.text!)
        dismiss(animated: true, completion: nil)
    }
    
    // Using closure method
    @IBAction func closeWithClosure(_ sender: UIButton) {
        callBack?(textToDisplayTextField.text!)
        dismiss(animated: true, completion: nil)
    }
}
