//
//  Player.swift
//  bananaClickerFirebase
//
//  Created by Peter Mickle on 2/12/25.
//

import Foundation
import FirebaseCore
import FirebaseDatabase

class Player{
    
    var ref = Database.database().reference()
    
    var name: String
    var highscore: Int
  
    
    init(name: String, highscore: Int) {
        self.name = name
        self.highscore = highscore
    }
    
    init(dict: [String: Any]){
        if let a = dict["highScore"] as? Int{
                highscore = a
            }
            else{
                highscore = 0
            }
        
        if let b = dict["name"] as? String{
                name = b
            }
            else{
                name = "john doe"
            }

    }
    
    func saveScore(){
        let dict = ["name": name, "highScore":highscore] as [String: Any]
        ref.child("players").childByAutoId().setValue(dict)
    }
    
    
    
    
}
