//
//  HomeScreen.swift
//  FatBit
//
//  Created by Anirudh Natarajan on 10/27/17.
//  Copyright © 2017 Anirudh Natarajan. All rights reserved.
//

import UIKit

var firstH = true
class HomeScreen: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    var selectedID = IndexPath()
    var images = ["smash", "movie", "soccer", "yoga"]
    var titles = ["Video Game Fun!", "Movie Time!", "Lets play some soccer!", "Yoga Time"]
    var location = ["Saint Francis High School", "Century Theatres, Great Mall", "Old Mission Park Soccer Field", "Bollywood Dance Studio, San Jose"]
    var username = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            view.endEditing(true)
        } else {
            let _ = searchBar.text!.lowercased()
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(firstH) {return 3}
        else {return 4}
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        
        if(firstH && indexPath.row < 3){
            print("yo")
            
            cell.thumbnail.image = UIImage(named: "\(images[indexPath.row+1]).png")
            cell.title.text = "\(titles[indexPath.row+1])"
            cell.location.text = "\(location[indexPath.row+1])"
        } else if (!firstH && indexPath.row < 4) {
            cell.thumbnail.image = UIImage(named: "\(images[indexPath.row]).png")
            cell.title.text = "\(titles[indexPath.row])"
            cell.location.text = "\(location[indexPath.row])"
            
        }
        return (cell)
    }

func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.performSegue(withIdentifier: "getInfo", sender: self)
}

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    firstH = false
    if let dest: ActivityInfoScreen = segue.destination as? ActivityInfoScreen {
        dest.fromProfile = false
    }
}

}
