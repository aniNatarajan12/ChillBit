//
//  AddActivityScreen.swift
//  FatBit
//
//  Created by Anirudh Natarajan on 10/28/17.
//  Copyright © 2017 Anirudh Natarajan. All rights reserved.
//

import Foundation
import UIKit
import EventKit

class AddActivityScreen: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    @IBOutlet var thumbnail: UIButton!
    @IBOutlet var titleLabel: UITextField!
    @IBOutlet var location: UITextField!
    @IBOutlet var startDate: UITextField!
    @IBOutlet var endDate: UITextField!
    @IBOutlet var activityNotes: UITextView!
    @IBOutlet var numberOfParticipants: UITextField!
    @IBOutlet var createButton: UIButton!
    @IBOutlet var thumbImg: UIImageView!
    
    var startDateD = Date()
    var endDateD = Date()
    
    let Ipicker = UIImagePickerController()
    
    func clear(){
        thumbnail.imageView?.image = nil
        titleLabel.text = ""
        location.text = ""
        startDate.text = ""
        endDate.text = ""
        activityNotes.text = ""
        numberOfParticipants.text = ""
    }
    
    let picker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        createDatePickerS()
        createDatePickerE()
        createButton.layer.cornerRadius = 20
        Ipicker.delegate = self
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AddActivityScreen.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func donePressedS(){
        startDateD = picker.date
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .medium
        
        startDate.text = "\(formatter.string(from: picker.date))"
        self.view.endEditing(true)
    }
    @objc func donePressedE(){
        endDateD = picker.date
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .medium
        
        endDate.text = "\(formatter.string(from: picker.date))"
        self.view.endEditing(true)
    }
    
    func createDatePickerS(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressedS))
        toolbar.setItems([done], animated: false)
        
        startDate.inputAccessoryView = toolbar
        startDate.inputView = picker
    }
    
    func createDatePickerE(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressedE))
        toolbar.setItems([done], animated: false)
        
        endDate.inputAccessoryView = toolbar
        endDate.inputView = picker
    }
    
    @IBAction func addImagePressed(_ sender: Any) {
        Ipicker.allowsEditing = false
        Ipicker.sourceType = .photoLibrary
        Ipicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        Ipicker.modalPresentationStyle = .popover
        present(Ipicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var bgImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        thumbImg.image = bgImage
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    let URL_SAVE_TEAM = "http://ec2-54-183-216-139.us-west-1.compute.amazonaws.com/fatBitScript.php"
    
    @IBAction func createPressed(_ sender: Any) {
        
        let requestURL = NSURL(string: URL_SAVE_TEAM)
        
        //creating NSMutableURLRequest
        let request = NSMutableURLRequest(url: requestURL! as URL)
        
        //setting the method to post
        request.httpMethod = "POST"
        
        //creating the post parameter by concatenating the keys and values from text field
        let postParameters = "username="+usn+"&title="+self.titleLabel.text!+"&location="+self.location.text!+"&possibleGoing="+self.numberOfParticipants.text!+"&startTime="+self.startDate.text!+"&endTime="+self.endDate.text!+"&notes="+self.activityNotes.text!
        //let postParameters = "username="+username+"&userPass="+password+"&hobby="+self.hobbyText.text!
        
        //adding the parameters to request body
        request.httpBody = postParameters.data(using: String.Encoding.utf8)
        
        print("POST: \(postParameters)")
        
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
        
        let eventStore:EKEventStore = EKEventStore()
        eventStore.requestAccess(to: .event) { (granted, error) in
            if(granted && error==nil){
                DispatchQueue.main.async {
                    let event:EKEvent = EKEvent(eventStore: eventStore)
                    event.title = self.titleLabel.text!
                    event.startDate = self.startDateD
                    event.endDate = self.endDateD
                    event.notes = self.activityNotes.text!
                    event.calendar = eventStore.defaultCalendarForNewEvents
                    do {
                        try eventStore.save(event, span: .thisEvent)
                        let alert = UIAlertController(title: "Event Created", message: "Whoooooooo!", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        self.clear()
                    } catch let error as NSError {
                        print("error: \(error)")
                    }
                }
            } else { print("error: \(String(describing: error))") }
        }
    }
    
}
