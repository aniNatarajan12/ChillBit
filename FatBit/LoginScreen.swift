//
//  LoginScreen.swift
//  FatBit
//
//  Created by Anirudh Natarajan on 10/27/17.
//  Copyright © 2017 Anirudh Natarajan. All rights reserved.
//

import Foundation
import UIKit

var usn = ""

class LoginScreen: UIViewController {
    @IBOutlet var usernameText: LoginTextField!
    @IBOutlet var passwordText: LoginTextField!
    @IBOutlet var errorText: UILabel!
    var pass:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorText.isHidden = true
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginScreen.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        // SEND
        
        let URL_SAVE_TEAM = "http://ec2-54-183-216-139.us-west-1.compute.amazonaws.com/fatBitScript.php?username=\(self.usernameText.text!)"
        let requestURL = NSURL(string: URL_SAVE_TEAM)
        
        //creating NSMutableURLRequest
        let request2 = NSMutableURLRequest(url: requestURL! as URL)
        let pass = self.passwordText.text!
        //setting the method to post
        request2.httpMethod = "GET"
        
        let username=self.usernameText.text!
        print("USR: \(username)")
        
        //creating the post parameter by concatenating the keys and values from text field
        let postParameters = "username="+username
        print("PP: \(postParameters)")
        
        //adding the parameters to request body
        request2.httpBody = postParameters.data(using: String.Encoding.utf8)
        
        
        //creating a task to send the post request
        let task2 = URLSession.shared.dataTask(with: request2 as URLRequest){
            data, response, error in
            print("done")
            if error != nil{
                print("error is \(error)")
                return
            }
            print("response = \(response)")
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("response string = \(responseString)")
            
            
//            let splitOne = responseString?.components(separatedBy: ",")
//            let splitTwo = splitOne?[0].components(separatedBy: ":")
//            let raw = splitTwo?[1]
//            let startIndex = raw?.index((raw?.startIndex)!, offsetBy: 1)
//            let endIndex = raw?.index((raw?.endIndex)!, offsetBy: -2)
//            let pswd = raw?[startIndex!...endIndex!]
            
            DispatchQueue.main.async {
                if(self.passwordText.text!==pass){
                    self.performSegue(withIdentifier: "loggedIn", sender: self)
                } else {
                    self.errorText.isHidden = false
                    print("\(self.passwordText.text!)")
                }
            }
        }
        task2.resume()
        usn = username
    }
}

