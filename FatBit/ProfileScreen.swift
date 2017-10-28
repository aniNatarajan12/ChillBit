//
//  ProfileController.swift
//  FatBit
//
//  Created by Anirudh Natarajan on 10/27/17.
//  Copyright © 2017 Anirudh Natarajan. All rights reserved.
//

import UIKit

class ProfileScreen: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet var username: UILabel!
    @IBOutlet var hobbies: UITextView!
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        username.text = "\(usn)"
        hobbies.text = "\(hobb)"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(1)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "titleCell", for: indexPath) as! TitleCell
        
        //fill in cell stuff
        
        cell.title.text = "Video Game Time"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        selectedID = indexPath
        self.performSegue(withIdentifier: "getMoreInfo", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest: ActivityInfoScreen = segue.destination as? ActivityInfoScreen {
            dest.fromProfile = true
        }
    }

}

