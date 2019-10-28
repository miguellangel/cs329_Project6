//
//  QuestLogViewController.swift
//  group14_assignment6
//
//  Created by Dana Brannon on 10/20/19.
//  Copyright © 2019 Dana Brannon. All rights reserved.
//

import UIKit
import os.log

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
    var adventurer: Adventurer?
    var timer: Timer?
    //var timer2 = Timer()
    var defeatedEnemies = 0
    var enemyHP = Float.random(in: 0 ... 100)
    var adventurerHP: Float = 0
    var adventurerLevel: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = "Beginning Quest...\n"
        //instead of let timer =
        self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(fireTimer(timer:)), userInfo: nil, repeats: true)
        
        
        // Set up views for new Quest for selected adventurer.
        if let adventurer = adventurer {
            characterImage.image = UIImage(named: adventurer.image)
            nameLabel.text = adventurer.name
            levelLabel.text = String(adventurer.level)
            occupationLabel.text = adventurer.profession
            attackLabel.text = String(adventurer.attackScore)
            hpLabel.text = adventurer.hpScore + "/" + adventurer.hpScore
        }
        //print(String(adventurer!.hpScore) + " is hpScore")
        
        self.adventurerHP = Float(adventurer!.hpScore) as! Float
        
        self.adventurerLevel = Int(adventurer!.level)
    }
    
    @objc func fireTimer(timer: Timer) {
        // Leveling up
        if (((defeatedEnemies % 3) == 0) && (defeatedEnemies != 0)){
            adventurerLevel += 1
            levelLabel.text = String(adventurerLevel)
            textView.insertText("\(adventurer!.name) has leveled up to Level \(adventurerLevel)\n")
        }
        
        // Dead enemy
        if enemyHP <= 0 {
            defeatedEnemies += 1
            textView.insertText("A new enemy appears!\n")
            enemyHP = Float.random(in: 0 ... 50)
        }
        
        // Adventurer attack
        let adventurerHit = Float.random(in: 0 ... 10) * adventurer!.attackScore
        enemyHP -= adventurerHit
        textView.insertText("\(adventurer!.name) attacks for " + String(format: "%.2f", adventurerHit) + " damage\n")
        
        // Monster attack
        let picker = Int.random(in: 0...1)
        if picker == 0 {
            textView.insertText("The monster is waiting...\n")
        } else {
            let monsterHit = Float.random(in: 0 ... 30)
            textView.insertText("The monster attacks for " + String(format: "%.2f", monsterHit) + " damage\n")
            adventurerHP -= monsterHit
            hpLabel.text = String(format: "%.2f", adventurerHP) + "/" + adventurer!.hpScore
        }
        
        // Dead adventurer
        if adventurerHP <= 0 {
            textView.insertText("\(adventurer!.name) died! Quest ended.\n")
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
        
        //print("End quest button has been pressed, prepped for segue!")
        
        let name = nameLabel.text ?? ""
        let photo = adventurer!.image
        let level = Int(levelLabel.text!)
        let profession = adventurer!.profession
        let attack = adventurer!.attackScore
        let hp = adventurer!.hpScore
        
        // Set the meal to be passed to MealTableViewController after the unwind segue.
        adventurer = Adventurer(name: name, level: level!, profession: profession, attackScore: attack, hpScore: hp, image: photo)
     }
}



