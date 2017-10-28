//
//  HobbiesScreen.swift
//  FatBit
//
//  Created by Anirudh Natarajan on 10/28/17.
//  Copyright © 2017 Anirudh Natarajan. All rights reserved.
//

import Foundation
import UIKit

var hobb = ""
class HobbiesScreen: UIViewController {
    
    @IBOutlet var hobbyText: UITextView!
    var username = String()
    var password = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(HobbiesScreen.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //URL to our web service
    let URL_SAVE_TEAM = "http://ec2-54-183-216-139.us-west-1.compute.amazonaws.com/fatBitScript.php"
    
    @IBAction func registerPressed(_ sender: Any) {
        //created NSURL
        let requestURL = NSURL(string: URL_SAVE_TEAM)
        
        //creating NSMutableURLRequest
        let request = NSMutableURLRequest(url: requestURL! as URL)
        
        //setting the method to post
        request.httpMethod = "POST"
        //getting values from text fields
        let username=self.username
        let password = self.password
        
        //creating the post parameter by concatenating the keys and values from text field
        let postParameters = "username="+username+"&userPass="+password+"&hobby="+self.hobbyText.text!
        
        //adding the parameters to request body
        request.httpBody = postParameters.data(using: String.Encoding.utf8)
        
        
        //creating a task to send the post request
        let task = URLSession.shared.dataTask(with: request as URLRequest){
            data, response, error in
            if error != nil{
                print("error is \(error)")
                return
            }
            print("response = \(response)")
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("response string = \(responseString)")
        }
        
        task.resume()
        
        usn = username
        hobb = self.hobbyText.text!
        self.performSegue(withIdentifier: "registered", sender: self)
    }
    
}


