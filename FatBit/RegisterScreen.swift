//
//  RegisterScreen.swift
//  FatBit
//
//  Created by Anirudh Natarajan on 10/27/17.
//  Copyright © 2017 Anirudh Natarajan. All rights reserved.
//

import Foundation
import UIKit

class RegisterScreen: UIViewController {
    @IBOutlet var usernameText: LoginTextField!
    @IBOutlet var passwordText: LoginTextField!
    @IBOutlet var confirmPasswordText: LoginTextField!
    @IBOutlet var errorText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorText.isHidden = true
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RegisterScreen.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registerPressed(_ sender: Any) {
        if(passwordText.text == confirmPasswordText.text){
            self.performSegue(withIdentifier: "getHobbies", sender: self)
        } else {
            errorText.isHidden = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destViewController: HobbiesScreen = segue.destination as? HobbiesScreen{
            destViewController.username = usernameText.text!
            destViewController.password = passwordText.text!
        }
        
        
        
    }
    
}
