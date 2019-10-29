//
//  QuestLogViewController.swift
//  group14_assignment6
//
//  Created by Dana Brannon on 10/20/19.
//  Copyright © 2019 Dana Brannon. All rights reserved.
//

import UIKit
import os.log
import CoreData

class QuestLogViewController: UIViewController {
    
    
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var occupationLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var hpLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var endQuestButton: UIButton!
    
    /*
     This value is either passed by `MealTableViewController` in `prepare(for:sender:)`
     or constructed as part of adding a new meal.
     */
    var adventurer: NSManagedObject?
    var timer: Timer?
    //var timer2 = Timer()
    var defeatedEnemies = 0
    var enemyHP = Float.random(in: 0 ... 100)
    
    // Adventurer Attributes
//    var name : String?
//    var level : Int?
//    var profession : String?
//    var attack : Float?
//    var appearance : String?
    var currentHP: Float?
//    var totalHP: Float?
//    var adventurerLevel: Int?
    


    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = "Beginning Quest...\n"
        //instead of let timer =
        self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(fireTimer(timer:)), userInfo: nil, repeats: true)
        
        
        // Set up views for new Quest for selected adventurer.
        if let adventurer = adventurer {
            let imageName = adventurer.value(forKey: "appearance") as! String
            // Fill-in label data from NSObject
            characterImage.image = UIImage(named: imageName)
            nameLabel.text = adventurer.value(forKeyPath: "name") as? String
            levelLabel.text = "\(adventurer.value(forKeyPath: "level")!)"
            occupationLabel.text = adventurer.value(forKeyPath: "profession") as? String
            var attack_ = adventurer.value(forKey: "attack") as! Float
            attackLabel.text = String(format: "%.2f", attack_)

            hpLabel.text = "\(adventurer.value(forKeyPath: "currentHP")!)" + "/" + "\(adventurer.value(forKeyPath: "totalHP")!)"
            
            // Set attribute values for class use
            self.currentHP = adventurer.value(forKey: "currentHP") as! Float
        }
    }
    
    @objc func fireTimer(timer: Timer) {
        // Leveling up
        if (((defeatedEnemies % 3) == 0) && (defeatedEnemies != 0)){
            print("Should level up")
            
            var adventurerLevel = Int(levelLabel.text!)! + 1
            levelLabel.text = "\(adventurerLevel)"
            textView.insertText("\(nameLabel.text!) has leveled up to Level \(adventurerLevel)\n")
        }
        
        // Dead enemy
        if enemyHP <= 0 {
            print("Enemy died")
            defeatedEnemies += 1
            print("Defeated: ", defeatedEnemies)
            textView.insertText("A new enemy appears!\n")
            enemyHP = Float.random(in: 0 ... 50)
        }
        
        // Adventurer attack
        let adventurerHit = Float.random(in: 0 ... 10) * Float(attackLabel.text!)!
        enemyHP -= adventurerHit
        
        textView.insertText("\(nameLabel.text!) attacks for " + String(format: "%.2f", adventurerHit) + " damage\n")
        
        // Monster attack
        let picker = Int.random(in: 0...1)
        if picker == 0 {
            textView.insertText("The monster is waiting...\n")
        } else {
            let monsterHit = Float.random(in: 0 ... 30)
            textView.insertText("The monster attacks for " + String(format: "%.2f", monsterHit) + " damage\n")
//            var adventurerHP : Float = adventurer!.value(forKey: "currentHP") as! Float
            var adventurerHP : Float = self.currentHP!
            adventurerHP -= monsterHit
            var totalHP : Float = adventurer!.value(forKey: "totalHP") as! Float
           self.currentHP = adventurerHP

            hpLabel.text = String(format: "%.2f", adventurerHP) + "/" + String(format: "%.2f", totalHP)
        }
        
        // Dead adventurer
        if (self.currentHP!.isLess(than: 0.0)) {
            textView.insertText("\(nameLabel.text!) died! Quest ended.\n")
            //timer.invalidate()
            stopTimer(timer: timer)
        }
    }
    
    @objc func stopTimer(timer: Timer) {
        timer.invalidate()
    }
    
    @IBAction func endQuestEndsTimer(_ sender: UIButton) {
        //print("End quest button has been pressed, timer called!")
        stopTimer(timer: self.timer!)
    }
    
     // MARK: - Navigation
    
     // This method lets you configure a view controller before it's presented.
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the endQuestButton is pressed.
        guard let button = sender as? UIButton, button === endQuestButton else {
            os_log("The End Quest button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        

     }
}



