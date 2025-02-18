//
//  LeaderboardViewControler.swift
//  bananaClickerFirebase
//
//  Created by Peter Mickle on 2/12/25.
//

import UIKit
import FirebaseCore
import FirebaseDatabase


class LeaderboardViewControlerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
 



    @IBOutlet weak var tableViewOutlet: UITableView!
    
    @IBOutlet weak var inputOutlet: UITextField!
    
    var addName = true
    
    
        var players : [Player] = []
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        tableViewOutlet.dataSource = self
        tableViewOutlet.delegate = self
        ref = Database.database().reference()
        
        
        ref.child("players").observe(.childAdded, with: { (snapshot) in
                   // snapshot is a dictionary with a key and a dictionary as a value
                    // this gets the dictionary from each snapshot
                    let dict = snapshot.value as! [String:Any]
                   
                    // building a Student object from the dictionary
                    let s = Player(dict: dict)
                    // adding the student object to the Student array
            for i in self.players {
                if i.name == s.name{
                    self.addName = false
                }
            }
            if self.addName{
                self.players.append(s)
            }
            self.addName = true
                     self.tableViewOutlet.reloadData()
        // should only add the student if the student isn’t already in the array
        // good place to update the tableview also
                    
                })

        
        //called after .childAdded is done
                ref.child("players").observeSingleEvent(of: .value, with: { snapshot in
                        print("--inital load has completed and the last user was read--")
                    print(self.players)
                    self.tableViewOutlet.reloadData()
                    })


        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewOutlet.dequeueReusableCell(withIdentifier: "myCell")!
        cell.textLabel?.text = "\(players[indexPath.row].name) score: \(players[indexPath.row].highscore)"
               return cell
    }
    
    
    @IBAction func saveAction(_ sender: UIButton) {
        var name = inputOutlet.text!
        var player = Player(name: name, highscore: AppData.money)
        players.append(player)
        player.saveScore()
        tableViewOutlet.reloadData()
    }
    
    
}
