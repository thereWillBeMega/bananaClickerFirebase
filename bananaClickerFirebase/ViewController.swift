//
//  ViewController.swift
//  bananaClickerFirebase
//
//  Created by Peter Mickle on 2/12/25.
//

import UIKit
import FirebaseCore
import FirebaseDatabase


class AppData{
    
    static var money = 0
    
}

class ViewController: UIViewController {

    var ref: DatabaseReference!
 
    
    
    @IBOutlet weak var textOutlet: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ref = Database.database().reference()
        
        
        
    }


    @IBAction func saveAction(_ sender: UIButton) {
        ref.child("money").childByAutoId().setValue(AppData.money)
    }
    
    
    @IBAction func clickAction(_ sender: UIButton) {
        AppData.money += 1
        textOutlet.text = "Money :\(AppData.money)"
    }
    
    
    
}

