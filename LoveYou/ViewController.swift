//
//  ViewController.swift
//  LoveYou
//
//  Created by Benjamin Patch on 10/27/15.
//  Copyright © 2015 PatchWork. All rights reserved.
//

import UIKit

enum Keys: String {
    case nameKey = "name"
}

class ViewController: UIViewController, UITextFieldDelegate {

    // MARK: Variables
    var name: String = ""
    let transitionTime = 0.5
    
    // MARK: Outlets
    
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    @IBOutlet weak var nameButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIButton!
    
    
    @IBOutlet var introView: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var textFieldLabel: UILabel!
    @IBOutlet weak var heartButton: UIButton!
    
    
    
    
    
    
    // MARK: Actions
    @IBAction func saveButtonTapped(sender: UIButton) {
        if nameTextField.text != "" {
            introView.alpha = 0
            var charArray = Array(nameTextField.text!.characters)
            // validate name by removing any excess spaces
            while (charArray[charArray.count - 1] == " "){
                charArray.removeLast()
            }
            name = String(charArray)
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject(name, forKey: Keys.nameKey.rawValue)
            heartButton.alpha = 0
            UIView.animateWithDuration(NSTimeInterval(transitionTime*2), animations: { () -> Void in
                self.heartButton.alpha = 1
            })
        }
        refreshButton.enabled = true
        nameButton.title = "Name"
        nameButton.enabled = true
    }

    @IBAction func heartButtonTapped(sender: UIButton) {
        self.textFieldLabel.text = "\(name) loves you!!"
        
        UIView.animateWithDuration(NSTimeInterval(transitionTime), animations: { () -> Void in
            self.heartButton.alpha = 0
            }) { (isComplete) -> Void in
                if isComplete {
                    UIView.animateWithDuration(NSTimeInterval(self.transitionTime/4), animations: { () -> Void in
                        self.textFieldLabel.alpha = 1
                    })
                }
        }
    }
    
    @IBAction func refreshButtonTapped(sender: UIBarButtonItem) {
        heartButton.alpha = 0.5
        UIView.animateWithDuration(NSTimeInterval(transitionTime/2), animations: { () -> Void in
            self.textFieldLabel.alpha = 0
            }) { (isComplete) -> Void in
                if isComplete{
                    UIView.animateWithDuration(NSTimeInterval(self.transitionTime)) { () -> Void in
                        self.heartButton.alpha = 1
                    }

                }
        }
    }
    
    @IBAction func nameButtonTapped(sender: UIBarButtonItem) {
        if introView.alpha == 0 {
            // view not visible
            
            refreshButton.enabled = false
            saveButton.enabled = false
            
            UIView.animateWithDuration(NSTimeInterval(0.2), animations: { () -> Void in
                self.nameButton.title = "Cancel"
            })

            UIView.animateWithDuration(NSTimeInterval(transitionTime), animations: { () -> Void in
                self.introView.alpha = 1
            })
            
            heartButton.alpha = 0
            textFieldLabel.alpha = 0
            
            nameTextField.text = name
        
        } else {
            // view visible 
            
            introView.alpha = 0
            refreshButton.enabled = true
            
            UIView.animateWithDuration(NSTimeInterval(0.2), animations: { () -> Void in
                self.nameButton.title = "Name"
            })

            heartButton.alpha = 0
            UIView.animateWithDuration(NSTimeInterval(transitionTime*2), animations: { () -> Void in
                self.heartButton.alpha = 1
            })
        }
        
        // disable save button
        // enable save button when text field is edited and does not equal the name
    }
    
    // MARK: Animation
//    func fadeHeartButton(fadeIn: Bool) {
//        if fadeIn {
//            
//        } else {
//            
//        }
//    }
    
    
    
    // MARK: TextField Delegate Methods
    
    func textFieldDidEndEditing(textField: UITextField) {
        print("resignfirstresponder")
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    func checkIfTextWasEdited() {
        if nameTextField.text != name {
            // name changed, enable save button
            saveButton.enabled = true
        } else {
            saveButton.enabled = false
        }
    }
    
    // MARK: Default Methods
    
    override func viewWillAppear(animated: Bool) {
        let defaults = NSUserDefaults.standardUserDefaults()
        if let tempName = defaults.stringForKey(Keys.nameKey.rawValue) {
            // name already set, go strait to the button
            print(tempName)
            name = tempName
            introView.alpha = 0
            textFieldLabel.alpha = 0
            UIView.animateWithDuration(NSTimeInterval(transitionTime), animations: { () -> Void in
                self.heartButton.alpha = 1
            })
            
        } else {
            refreshButton.enabled = false
            nameButton.enabled = false
            saveButton.enabled = false

            introView.alpha = 1
            heartButton.alpha = 0
            textFieldLabel.alpha = 0
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    
        nameTextField.addTarget(self, action: "checkIfTextWasEdited", forControlEvents: UIControlEvents.EditingChanged)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

