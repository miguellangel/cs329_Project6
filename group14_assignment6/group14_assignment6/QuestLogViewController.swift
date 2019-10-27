//
//  QuestLogViewController.swift
//  group14_assignment6
//
//  Created by Dana Brannon on 10/20/19.
//  Copyright © 2019 Dana Brannon. All rights reserved.
//

import UIKit

class QuestLogViewController: UIViewController {
    
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var occupationLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var hpLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    /*
     This value is either passed by `MealTableViewController` in `prepare(for:sender:)`
     or constructed as part of adding a new meal.
     */
    var adventurer: Adventurer?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set up views if editing an existing Meal.
        if let adventurer = adventurer {
            //navigationItem.title = meal.name
            //characterImage.image = adventurer.image
            nameLabel.text = adventurer.name
            levelLabel.text = String(adventurer.level)
            occupationLabel.text = adventurer.profession
            attackLabel.text = String(adventurer.attackScore)
            hpLabel.text = adventurer.hpScore
            //photoImageView.image = meal.photo
            //ratingControl.rating = meal.rating
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
