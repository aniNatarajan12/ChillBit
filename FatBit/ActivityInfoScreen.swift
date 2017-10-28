//
//  ActivityInfoScreen.swift
//  FatBit
//
//  Created by Anirudh Natarajan on 10/28/17.
//  Copyright © 2017 Anirudh Natarajan. All rights reserved.
//

import Foundation
import UIKit
import EventKit

class ActivityInfoScreen: UIViewController {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var thumbnail: UIImageView!
    @IBOutlet var activityNotes: UITextView!
    @IBOutlet var startDate: UILabel!
    @IBOutlet var endDate: UILabel!
    @IBOutlet var location: UILabel!
    @IBOutlet var numOfGuests: UILabel!
    @IBOutlet var goingButton: UIButton!
    
    var fromProfile = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goingButton.layer.cornerRadius = 20
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if(fromProfile){
            goingButton.setTitle("Signed Up", for: .normal)
            goingButton.isEnabled = false
        } else {
            goingButton.setTitle("Going", for: .normal)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backPressed(_ sender: Any) {
        if(fromProfile){
            self.performSegue(withIdentifier: "backToProfile", sender: self)
        } else {
            self.performSegue(withIdentifier: "backToFeed", sender: self)
        }
    }
    @IBAction func goingPressed(_ sender: Any) {
        //increase guest by one
        
        let eventStore:EKEventStore = EKEventStore()
        eventStore.requestAccess(to: .event) { (granted, error) in
            if(granted && error==nil){
                DispatchQueue.main.async {
                    let event:EKEvent = EKEvent(eventStore: eventStore)
                    event.title = self.titleLabel.text!
                    let dateFormatter = DateFormatter()
                    event.startDate = dateFormatter.date(from: self.startDate.text!)
                    event.endDate = dateFormatter.date(from: self.endDate.text!)
                    event.notes = self.activityNotes.text!
                    event.calendar = eventStore.defaultCalendarForNewEvents
                    do {
                        try eventStore.save(event, span: .thisEvent)
                        let alert = UIAlertController(title: "Event Added.", message: "Whoooooooo!", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    } catch let error as NSError {
                        print("error: \(error)")
                    }
                }
            } else { print("error: \(error)") }
        }
        
        if(fromProfile){
            self.performSegue(withIdentifier: "backToProfile", sender: self)
        } else {
            self.performSegue(withIdentifier: "backToFeed", sender: self)
        }
    }
    
}
