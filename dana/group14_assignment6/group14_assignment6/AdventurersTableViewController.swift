//
//  AdventurersTableViewController.swift
//  group14_assignment6
//
//  Created by Dana Brannon on 10/20/19.
//  Copyright © 2019 Dana Brannon. All rights reserved.
//

import UIKit

class AdventurersTableViewController: UITableViewController {
    
    var adventurers = [
        Adventurer(name: "Cloud", level: 5, profession: "SOLDIER", attackScore: 3.40, hpScore: "105/105", image: "cloudImage"),
        Adventurer(name: "Tifa", level: 5, profession: "Bartender", attackScore: 3.78, hpScore: "98/98", image: "tifaImage"),
        Adventurer(name: "Yuffie", level: 4, profession: "Thief", attackScore: 2.99, hpScore: "99/99", image: "yuffieImage"),
        Adventurer(name: "Vincent", level: 3, profession: "Store Clerk", attackScore: 2.00, hpScore: "70/70", image: "vincentImage"),
        Adventurer(name: "Link", level: 9, profession: "Archer", attackScore: 4.86, hpScore: "110/110", image: "linkImage")

    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return adventurers.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AdventurersTableViewCell", for: indexPath) as! AdventurersTableViewCell
        
        // Configure the cell
        //let headline = headlines[indexPath.row]
        let adventurer = adventurers[indexPath.section]
        
        cell.nameLabel.text = adventurer.name
        cell.levelLabel.text = "\(adventurer.level)"
        cell.professionLabel.text = adventurer.profession
        cell.attackLabel.text = "Attack:"
        cell.attackScoreLabel.text = "\(adventurer.attackScore)"
        cell.hpLabel.text = "HP:"
        cell.hpScoreLabel.text = "\(adventurer.hpScore)"
        cell.imageView?.image = UIImage(named: adventurer.image)
        
        return cell
    }
    
    // Set table row height
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 121
    }

    // MARK: Actions
    @IBAction func unwindToAdventurersList(sender: UIStoryboardSegue) {
        //if let sourceViewController = sender.source as? NewAdventurerViewController, //let meal = sourceViewController.meal{
            
            // Add a new meal.
            //let newIndexPath = IndexPath(row: meals.count, section: 0)
            
            //meals.append(meal)
            //tableView.insertRows(at: [newIndexPath], with: .automatic)
        }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
